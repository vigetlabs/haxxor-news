require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should not create session with invalid credentials" do
    post login_path, params: {name: @user.name, password: "wrongpassword"}
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end

  describe "when logged in" do
    before do
      log_in_as(@user)
    end

    it "should create session with valid credentials" do
      assert_redirected_to @user
      assert_equal @user.id, session[:user_id]
    end

    it "should destroy session" do
      delete logout_path
      assert_redirected_to login_path
      assert_nil session[:user_id]
    end
  end
end
