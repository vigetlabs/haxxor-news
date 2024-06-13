require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  setup do
    @article = build(:article)
  end

  test "should be valid with valid attributes" do
    assert @article.valid?
  end

  test "should not be valid without a title" do
    @article.title = nil
    assert_not @article.valid?, "Article is valid without a title"
  end

  test "should not be valid without a link" do
    @article.link = nil
    assert_not @article.valid?, "Article is valid without a link"
  end

  test "should not be valid without a user" do
    @article.user = nil
    assert_not @article.valid?, "Article is valid without a user"
  end
end
