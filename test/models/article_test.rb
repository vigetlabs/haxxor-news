require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  setup do
    @article = FactoryBot.build(:article)
  end

  test "should be valid with valid attributes" do
    assert @article.valid?
  end

  test "should not be valid without a title" do
    @article.title = nil
    assert_not @article.valid?
  end

  test "should not be valid without a link" do
    @article.link = nil
    assert_not @article.valid?
  end
end
