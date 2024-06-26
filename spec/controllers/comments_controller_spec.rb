require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:comment) { create(:comment, user: user, article: article) }
  let(:parent_comment) { create(:comment, article: article, user: user) }
  let(:comment_params) { {text: "This is a test comment"} }
  let(:reply_params) { {text: "This is a test reply", parent_id: parent_comment.id} }

  it "should not create comment when not logged in" do
    expect {
      post :create, params: {article_id: article.id, comment: comment_params}
    }.not_to change {
      Comment.count
    }
  end

  it "should redirect to login path when not logged in" do
    expect(post(:create, params: {article_id: article.id, comment: comment_params})).to redirect_to login_path
  end

  describe "when logged in" do
    before do
      log_in_as(user)
    end

    it "should create comment when logged in" do
      expect {
        post :create, params: {article_id: article.id, comment: comment_params}
      }.to change {
        Comment.count
      }.by(1)
    end

    it "should create a reply to a comment" do
      parent_comment
      expect {
        post :create, params: {article_id: article.id, comment: reply_params}
      }.to change { Comment.count }.by(1)
      expect(Comment.last.parent_id).to eq(parent_comment.id)
    end

    it "should redirect to article after comment creation" do
      expect(post(:create, params: {article_id: article.id, comment: comment_params})).to redirect_to article_path(article)
    end

    it "should not create comment with invalid params" do
      expect {
        post :create, params: {article_id: article.id, comment: {text: ""}}
      }.not_to change {
        Comment.count
      }
      expect(response.code).to eq("422")
    end

    describe "POST #upvote" do
      it "sets vote value to 1 if user has not voted" do
        expect {
          post :upvote, params: {article_id: article.id, id: comment.id}, format: :json
        }.to change { comment.votes.count }.by(1)
        expect(comment.reload.votes.last.value).to eq(1)
      end

      it "sets vote value to 0 if user has already upvoted" do
        create(:vote, votable: comment, user: user, value: 1)
        expect {
          post :upvote, params: {article_id: article.id, id: comment.id}, format: :json
        }.not_to change { comment.votes.count }
        expect(comment.reload.votes.last.value).to eq(0)
      end
    end

    describe "POST #downvote" do
      it "sets vote value to -1 if user has not already downvoted" do
        expect {
          post :downvote, params: {article_id: article.id, id: comment.id}, format: :json
        }.to change { comment.votes.count }.by(1)
        expect(comment.reload.votes.last.value).to eq(-1)
      end

      it "sets vote value to 0 if user has already downvoted" do
        create(:vote, votable: comment, user: user, value: -1)
        expect {
          post :downvote, params: {article_id: article.id, id: comment.id}, format: :json
        }.not_to change { comment.votes.count }
        expect(comment.reload.votes.last.value).to eq(0)
      end
    end
  end
end
