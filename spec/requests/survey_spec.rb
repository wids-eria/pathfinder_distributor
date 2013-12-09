require 'spec_helper.rb'

describe 'Tests Site Flow' do
  let!(:user) { Fabricate :user}

  it 'redirects unlogged users to Sign in' do
    visit game_url
    page.should have_content('Sign in')
  end
end