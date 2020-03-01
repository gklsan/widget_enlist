class ApplicationController < ActionController::Base
  rescue_from URI::InvalidURIError,
              RestClient::UnprocessableEntity, with: :common_errors

  rescue_from RestClient::Unauthorized, with: :common_errors

  private

  def authenticate_user
    redirect_to(root_path, alert_notification_text('Please signup/login to continue.')) && return unless session[:access_token]
  end

  def unauthorized_error
    redirect_to root_path, alert: 'Please re-login to continue.'
    true
  end

  def common_errors
    redirect_to root_path, alert_notification_text
    true
  end

  def alert_notification_text(txt = "Can't process request right now")
    { alert: txt }
  end
end
