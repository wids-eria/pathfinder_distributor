require 'spec_helper'

describe GameController do
  render_views
  include ADADataHelpers

  let!(:user) { Fabricate :user, consented: true, survey: true}
  let!(:player) { Fabricate :user,ada_id: 2, consented: true, survey: false}

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in :user, user
  end

  describe "Test IAT Flow" do
    it "gets game through iat" do
      AddPreIAT(user)
      session[:ada_id] = user.ada_id

      get :player
      response.should be_success
    end

    it "redirects to pre iat" do
      session[:ada_id] = user.ada_id

      get :player
      response.should redirect_to(preiat_url)
    end

    it "redirects to post iat" do
      AddPreIAT(user)
      session[:ada_id] = user.ada_id

      get :complete
      response.should redirect_to(postiat_url)
    end
  end

  describe "Test Consent Flow" do
    it "works for a consenting game user" do
      AddPreIAT(user)
      session[:ada_id] = user.ada_id
      get :player
      response.should be_success
    end

    it "redirects for a consenting control user" do
      session[:ada_id] = player.ada_id

      get :player
      response.should  redirect_to(survey_url)
    end
  end

  describe "Test Replaying user flow" do
    it "gets complete url" do
      FinishedIATs(user)
      session[:ada_id] = user.ada_id

      get :complete
      response.should be_success
    end

    it "User can play again" do
      FinishedIATs(user)
      session[:ada_id] = user.ada_id

      get :player
      response.should be_success
    end
  end
end
