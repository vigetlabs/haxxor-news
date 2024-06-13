require "test_helper"

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  include FactoryBot::Syntax::Methods

  setup do
    @user = create(:user)
  end

  test "should get current_user when logged in" do
    log_in_as(@user)
    get root_path
    assert_equal @user, @controller.current_user
  end

  test "should return nil for current_user when not logged in" do
    get root_path
    assert_nil @controller.current_user
  end

  test "should return true for logged_in? when logged in" do
    log_in_as(@user)
    get root_path
    assert @controller.logged_in?
  end

  test "should return false for logged_in? when not logged in" do
    get root_path
    assert_not @controller.logged_in?
  end

  test "should redirect to login when not authorized" do
    get user_path(@user)
    assert_redirected_to login_path
  end

  test "should not redirect to login when authorized" do
    log_in_as(@user)
    get user_path(@user)
    assert_response :success
  end

  test "should return true for home? when on root path" do
    get root_path
    assert @controller.home?
  end

  test "should return false for home? when not on root path" do
    get user_path(@user)
    assert_not @controller.home?
  end

  private

  # Simulate a logged-in user
  def log_in_as(user)
    post login_url, params: {name: user.name, password: "password"}
  end
end
