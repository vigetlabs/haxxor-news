require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user) }

  it "should get new" do
    get :new

    expect(response.code).to eq("200")
  end

  it "should not create session with invalid credentials" do
    post :create, params: {name: user.name, password: "wrongpassword"}

    expect(session[:user_id]).to be_nil
  end

  it "should redirect after failed login" do
    expect(post :create, params: {name: user.name, password: "wrongpassword"}).to redirect_to root_path
  end

  it "should create session with valid credentials" do
    post :create, params: {name: user.name, password: "password"}

    expect(session[:user_id]).to eq(user.id)
  end

  it "should redirect to the user path after login" do
    expect(post :create, params: {name: user.name, password: "password"}).to redirect_to user_path(user)
  end

  describe "when logged in" do
    before do
      log_in_as(user)
    end

    it "should destroy session" do
      delete :destroy

      expect(session[:user_id]).to be_nil
    end

    it "should redirect to login page after logout" do
      expect(delete :destroy).to redirect_to login_path
    end
  end
end
