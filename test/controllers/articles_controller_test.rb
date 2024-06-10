require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one) 
  end

  test "should get index" do
    get articles_url
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url, params: {article: {title: "Hello Rails", link: "http://rails.com"}}
    end
    assert_redirected_to article_path(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should not create article with invalid params" do
    assert_no_difference("Article.count") do
      post articles_url, params: {article: {title: "", link: ""}}
    end
    assert_response :unprocessable_entity
  end
end
