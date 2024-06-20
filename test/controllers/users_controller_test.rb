require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @valid_user_params = {user: attributes_for(:user)}
    @invalid_user_params = {user: {name: "", email: "invalid", password: "pass", password_confirmation: "word"}}
  end

  test "should create user with valid params" do
    assert_difference("User.count", 1) do
      post users_path, params: @valid_user_params
    end
    assert_redirected_to user_path(User.last)
  end

  test "should not create user with invalid params" do
    assert_no_difference("User.count") do
      post users_path, params: @invalid_user_params
    end
    assert_redirected_to root_path
  end

  test "should show user when authorized" do
    log_in_as(@user)
    get user_path(@user)
    assert_response :success
    assert_select "h1", @user.name
  end
end
