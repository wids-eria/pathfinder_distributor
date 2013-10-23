class DistributorController < ApplicationController
  before_filter :present_login
  before_filter :must_consent

  def index
    redirect_to game_url
  end

  def survey
    @redirect_url = postsurvey_url
  end

  def postsurvey
    id = current_user.id
    current_user = User.update(id,{survey: true, renew_survey: false})

    redirect_to game_url
  end
end