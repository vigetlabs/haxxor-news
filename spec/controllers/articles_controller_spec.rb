require "rails_helper"

RSpec.describe ArticlesController, type: :controller do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }

  it "should get index" do
    get :index

    expect(response.code).to eq("200")
  end

  it "should redirect new when not logged in" do
    expect(get :new).to redirect_to login_path
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
  end
end
