class V1::UrlsController < V1::BaseController
  def create
    url = UrlShorterService.call(url_params)
    respond_with url, location: v1_url_path(url)
  end


  private

  def url_params
    params.require(:url).permit(:long)
  end
end
