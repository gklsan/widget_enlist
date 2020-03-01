module Authentication
  private

  def user_login
    response = RestClient.post "#{auth_url}/token", login_params
    token = response.code == 200 ? JSON.parse(response).dig('data', 'token') : nil
    session[:access_token] = token['access_token'] if token
  end

  def user_logout
    response = RestClient.post "#{auth_url}/revoke", { token: session[:access_token] }, auth_header
    return nil unless response.code == 200

    reset_session
    JSON.parse(response).dig('data')
  end

  def auth_url
    "#{ENV['BASE_URL']}/oauth"
  end

  def grant_type
    {
      grant_type: "password"
    }
  end

  def login_params
    client_id_and_secret.
      merge(grant_type).
      merge(transformed_user_params)
  end

  def transformed_user_params
    user_params.to_h.slice('email', 'password').transform_keys{|key| key == 'email' ? 'username' : key}
  end

  def auth_header
    { Authorization: "Bearer #{session[:access_token]}" }
  end
end
