require 'spec_helper'

describe GameController do
  render_views

  let!(:user) { Fabricate :user, consented: true, survey: true}
  let!(:player) { Fabricate :user,ada_id: 2, consented: true, survey: false}

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in :user, user
  end

  describe "GET 'player'" do
    it "works for a consenting game user" do
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
end
