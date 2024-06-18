require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @article = create(:article, user: @user)
    @comment_params = {text: "This is a test comment"}
  end
  test "should not create comment when not logged in" do
    assert_no_difference "Comment.count" do
      post article_comments_path(@article), params: {comment: @comment_params}
    end
    assert_redirected_to login_path
  end

  describe "when logged in" do
    before do
      @user = create(:user) # There are errors if I don't add this line. didn't need this in articles_controller_test
      log_in_as(@user)
    end

    it "should create comment when logged in" do
      assert_difference("Comment.count", 1) do
        post article_comments_path(@article), params: {comment: @comment_params}
      end
      assert_redirected_to @article
    end
    it "should not create comment with invalid params" do
      assert_no_difference "Comment.count" do
        post article_comments_path(@article), params: {comment: {text: ""}}
      end
      assert_response :unprocessable_entity
    end
  end
end
