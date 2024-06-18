require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @article = create(:article, user: @user)
    @comment = Comment.new(text: "This is a test comment", article: @article, user: @user)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "text should be present" do
    @comment.text = " "
    assert_not @comment.valid?
  end

  test "should belong to an article" do
    @comment.article = nil
    assert_not @comment.valid?
  end

  test "should belong to a user" do
    @comment.user = nil
    assert_not @comment.valid?
  end
end
