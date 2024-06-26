require "rails_helper"

RSpec.describe ArticlesController, type: :controller do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  it "should get index" do
    get :index

    expect(response.code).to eq("200")
  end

  it "should redirect new when not logged in" do
    expect(get(:new)).to redirect_to login_path
  end

  it "should show article" do
    get :show, params: {id: article.id}

    expect(response.code).to eq("200")
  end

  describe "when logged in" do
    before do
      log_in_as(user)
    end

    it "should be able to make new article" do
      get :new

      expect(response.code).to eq("200")
    end

    it "should create article" do
      expect {
        post :create, params: {article: {title: "New Article", link: "https://newlink.com"}}
      }.to change {
        Article.count
      }.by(1)
    end

    describe "POST #upvote" do
      it "sets vote value to 1 if user has not voted" do
        expect {
          post :upvote, params: {id: article.id}, format: :json
        }.to change { article.votes.count }.by(1)
        expect(article.reload.votes.last.value).to eq(1)
      end

      it "sets vote value to 0 if user has already upvoted" do
        create(:vote, votable: article, user: user, value: 1)
        expect {
          post :upvote, params: {id: article.id}, format: :json
        }.not_to change { article.votes.count }
        expect(article.reload.votes.last.value).to eq(0)
      end
    end

    describe "POST #downvote" do
      it "sets vote value to -1 if user has not already downvoted" do
        expect {
          post :downvote, params: {id: article.id}, format: :json
        }.to change { article.votes.count }.by(1)
        expect(article.reload.votes.last.value).to eq(-1)
      end

      it "sets vote value to 0 if user has already downvoted" do
        create(:vote, votable: article, user: user, value: -1)
        expect {
          post :downvote, params: {id: article.id}, format: :json
        }.not_to change { article.votes.count }
        expect(article.reload.votes.last.value).to eq(0)
      end
    end
  end
end
