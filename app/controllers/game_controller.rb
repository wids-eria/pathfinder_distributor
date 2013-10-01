class GameController < ApplicationController
  before_filter :present_login
  before_filter :must_consent
  before_filter :iat_required, except: [:iat]

  def player
    authorize! :read, :game
  end

  def iat
    unless current_user.iat
      if current_user.control?
        @version = 'A'
      else
        @version = 'B'
      end
    else
      redirect_to game_url
    end
  end
end