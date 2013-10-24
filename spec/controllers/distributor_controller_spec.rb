require 'spec_helper'

describe DistributorController do
  render_views

  let!(:user) { Fabricate :user}

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in :user, user
  end

  it 'redirects unlogged users to Sign in' do
    visit root_url
    page.should have_content('Sign in')
  end
end