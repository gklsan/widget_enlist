class ApplicationController < ActionController::Base
  rescue_from URI::InvalidURIError,
              RestClient::UnprocessableEntity, :with => :common_errors

  rescue_from RestClient::Unauthorized, :with => :common_errors

  def unauthorized_error
    redirect_to root_path, alert: 'Please re-login to continue.'
    true
  end

  def common_errors
    redirect_to root_path, alert: "Can't process request right now"
    true
  end
end
