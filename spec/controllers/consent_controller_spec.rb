require 'spec_helper'

describe ConsentController do
  render_views

  let!(:user) { Fabricate :user,consented: true}
  before do
    sign_in :user, user
  end

  describe "GET 'consent_form'" do
    it "redirects unlogged users to sign in" do
      get "form"
      response.should redirect_to(new_user_session_path)
    end

    it "logged in user gets consent form" do
      session[:ada_id] = user.ada_id
      get 'form'
      response.should be_success
    end
  end

  describe "PUT 'consent'" do
    it "sets user consent to true" do
      session[:ada_id] = user.ada_id
      put 'consent', user: user
      user.reload
      user.consented.should eq(true)
    end
  end
end