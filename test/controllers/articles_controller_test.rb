require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @article = create(:article, user: @user)
  end
  test "should get index" do
    get articles_url
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test "should redirect new when not logged in" do
    get new_article_url
    assert_redirected_to login_url
  end

  test "should not go to new article page if not logged in" do
    get new_article_path
    assert_redirected_to login_url
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  describe "when logged in" do
    before do
      log_in_as(@user)
    end

    it "should be able to make new article" do
      get new_article_path
      assert_response :success
    end

    it "should create article" do
      assert_difference("Article.count", 1) do
        post articles_url, params: {article: {title: "New Article", link: "https://newlink.com"}}
      end
    end
  end
end
