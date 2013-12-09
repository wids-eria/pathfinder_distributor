class SessionController < ApplicationController
  skip_authorization_check
  before_filter :login_required, except: [:from_oauth, :destroy, :create]

  def from_oauth
    omniauth = env['omniauth.auth']

    unless omniauth.nil?
      session[:token] = omniauth['credentials']['token']
      session[:player_name] = omniauth['extra']['raw_info']['info']['player_name']
      session[:auth] = omniauth['extra']['raw_info']['info']['auth']
      session[:ada_id] = omniauth['uid']

      User.create_from_session(session)
    end

    redirect_to root_url
  end

  def login
    redirect_to root_url
  end

  def destroy
    reset_session

    flash[:notice] = %Q[You have been logged out of Fairplay but are still logged into your <a href="http://ada.production.eriainteractive.com">GLS account.</a>].html_safe
    redirect_to new_user_session_path
  end

  def failure
    render :text => params[:message]
  end

end