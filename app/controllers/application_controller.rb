class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    return User.find_by_ada_id(session[:ada_id])
  end

  def present_login
    unless current_user
      redirect_to new_user_session_path
    end
  end

  def iat_required
    user_id  = session[:ada_id]
    unless User.find_by_ada_id(user_id).iat
      redirect_to iat_url
    end
  end

  def login_required
    if !current_user
      respond_to do |format|
        session[:type] = request.query_parameters['type']
        format.html  {
          redirect_to '/auth/ada'
        }
        format.json {
          render :json => { 'error' => 'Access Denied' }.to_json
        }
      end
    end
  end
  private

  def must_consent
    unless current_user.consented?
      redirect_to consent_form_url
    end
  end
end
