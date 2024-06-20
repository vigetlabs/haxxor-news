require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:comment_params) { {text: "This is a test comment"} }

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
  end
end
