module User
  private

  def create_user
    response = RestClient.post url, client_id_and_secret.merge({user: user_params.to_h})
    return nil unless response.code == 200

    user_login
    JSON.parse(response).dig('data', 'user')
  end

  def user
    response = RestClient.get "#{url}/#{params[:id]}", params_with_auth_header
    response.code == 200 ? JSON.parse(response).dig('data', 'user') : []
  end

  def user_widgets
    response = RestClient.get "#{url}/#{params[:id]}/widgets", params_with_auth_header
    response.code == 200 ? JSON.parse(response).dig('data', 'widgets') : []
  end

  def url
    "#{ENV['BASE_URL']}/api/v1/users"
  end

  def params_with_auth_header
    auth_header.merge(params: client_id_and_secret)
  end

  def client_id_and_secret
    {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET']
    }
  end
end
