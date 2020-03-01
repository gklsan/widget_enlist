module Widget
  private

  def public_widgets
    response = RestClient.get "#{url}/visible", params: client_id_and_secret.merge(term)
    response.code == 200 ? JSON.parse(response).dig('data', 'widgets') : []
  end

  def term
    return {} if params[:term].blank?

    { term: params[:term].to_s }
  end

  def url
    "#{ENV['BASE_URL']}/api/v1/widgets"
  end

  def client_id_and_secret
    {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET']
    }
  end
end
