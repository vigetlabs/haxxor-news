require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  setup do
    @user = create(:user)
  end

  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should create session with valid credentials" do
    post login_path, params: {name: @user.name, password: "password"}
    assert_redirected_to @user
    assert_equal @user.id, session[:user_id]
  end

  test "should not create session with invalid credentials" do
    post login_path, params: {name: @user.name, password: "wrongpassword"}
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end

  test "should destroy session" do
    log_in_as(@user)
    delete logout_path
    assert_redirected_to login_path
    assert_nil session[:user_id]
  end

  private

  def log_in_as(user)
    post login_path, params: {name: user.name, password: "password"}
  end
end
