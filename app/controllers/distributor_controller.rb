class DistributorController < ApplicationController
  before_filter :present_login
  before_filter :must_consent

  def index
    if current_user.control_group?
      redirect_to "http://fairplay.control.dev.eriainteractive.com"
    else
      redirect_to game_url
    end
  end

  def survey
    @redirect_url = postsurvey_url
  end

  def login
    redirect_to root_url
  end

  def postsurvey
    id = current_user.id
    current_user = User.update(id,{survey: Time.now})

    redirect_to game_url
  end
end
