require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = FactoryBot.create(:user)
    @article = FactoryBot.create(:article, user: @user)
    @other_user = FactoryBot.create(:user, email: "other@example.com")
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

  test "should create article if logged in" do
    log_in_as(@user)
    assert_difference('Article.count', 1) do
      post articles_url, params: { article: { title: "New Article", link: "https://newlink.com" } }
    end
    assert_redirected_to article_path(Article.last)
  end

  test "should not create article if not logged in" do
    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: "New Article", link: "https://newlink.com" } }
    end
    assert_redirected_to login_url
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  private

  # Simulate a logged-in user
  def log_in_as(user)
    post login_url, params: { session: { email: user.email, password: 'password' } }
  end
end
