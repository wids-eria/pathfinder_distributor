class GameController < ApplicationController
  before_filter :present_login
  before_filter :must_consent
  before_filter :require_survey
  #before_filter :require_pre_iat, only: [:player,:post_iat,:complete]
  #before_filter :require_post_iat, only: [:complete]

  def player
    authorize! :read, :game

    if current_user.control?
      @version = 'A'
    else
      @version = 'B'
    end
  end

  def pre_iat
    unless current_user.pre
      @version = 'Pre'

      render "iat"
    end
  end

  def post_iat
    unless current_user.post
      @version = 'Post'
      render "iat"
    end
  end

  def complete
  end

  private

  def require_pre_iat
    unless current_user.pre
      if request.referer == preiat_url
        flash[:notice] = "You must complete the IAT before continuing!"
      end

      redirect_to preiat_url
    end
  end

  def require_post_iat
    unless current_user.post
      if request.referer == preiat_url
        flash[:notice] = "You must complete the IAT before continuing!"
      end

      redirect_to postiat_url
    end
  end

end