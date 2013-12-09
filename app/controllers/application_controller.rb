class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    unless session[:ada_id].nil?
      return User.find_by_ada_id(session[:ada_id])
    else
      return nil
    end
  end

  def present_login
    unless current_user
      redirect_to new_user_session_path
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

  def require_survey
    unless current_user.survey >= Survey.last.updated_at
      redirect_to survey_url
    end
  end

  private

  def must_consent
    unless current_user.consented >= Irb.last.updated_at
      redirect_to consent_form_url
    end
  end
end
