class ConsentController < ApplicationController
  before_filter :present_login

  def form
  end

  def consent
    @user = current_user
    @user.consented = true
    @user.renew_consent = false
    @user.save!
    redirect_to root_url
  end
end