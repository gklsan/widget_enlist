module Widget
  private

  def public_widgets
    response = RestClient.get "#{widget_url}/visible", params: client_id_and_secret.merge(term)
    response.code == 200 ? JSON.parse(response).dig('data', 'widgets') : []
  end

  def update_widget
    response = RestClient.put "#{widget_url}/#{params[:id]}",
                              { widget: widget_params.to_h },
                              auth_header
    response.code == 200 ? JSON.parse(response).dig('data', 'widget') : []
  end

  def create_widget
    RestClient.post widget_url, { widget: widget_params.to_h }, auth_header
  end

  def remove_widget
    RestClient.delete "#{widget_url}/#{params[:id]}", auth_header
  end

  def term
    return {} if params[:term].blank?

    { term: params[:term].to_s }
  end

  def widget_url
    "#{ENV['BASE_URL']}/api/v1/widgets"
  end

  def client_id_and_secret
    {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET']
    }
  end
end
