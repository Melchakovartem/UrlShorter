class V1::UrlsController < V1::BaseController
  def create
    url = Url.find_or_create_by(url_params)
    json = V1::ShortUrlSerializer.new(url).serialized_json
    respond_with json, location: v1_url_path(url)
  end


  private

  def url_params
    params.require(:url).permit(:long)
  end
end
