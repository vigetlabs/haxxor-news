require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_user_params) { {user: {name: "RonSwanson", email: "ron.swanson@pawnee.parks.gov", password: "password", password_confirmation: "password"}} }
  let(:invalid_user_params) { {user: {name: "", email: "invalid", password: "pass", password_confirmation: "word"}} }

  describe "when logged in" do
    before do
      log_in_as(user)
    end

    it "should not redirect to login when authorized" do
      get :show, params: {id: user.id}

      expect(response.code).to eq("200")
    end
  end

  it "should redirect to login when not authorized" do
    expect(get(:show, params: {id: user.id})).to redirect_to login_path
  end

  it "should create user with valid params" do
    expect {
      post :create, params: valid_user_params
    }.to change {
      User.count
    }.by(1)
  end

  it "redirects after successful creation" do
    expect(post(:create, params: valid_user_params)).to redirect_to user_path(User.last)
  end

  it "should not create user with invalid params" do
    expect {
      post :create, params: invalid_user_params
    }.not_to change {
      User.count
    }
  end

  it "redirects after failed creation" do
    expect(post(:create, params: invalid_user_params)).to redirect_to root_path
  end
end
