class V1::UrlsController < V1::BaseController
  before_action :load_url

  def create
    url = Url.find_or_create_by(url_params)
    json = V1::ShortUrlSerializer.new(url).serialized_json
    respond_with json, location: v1_url_path(url)
  end

  def show
    @url.change_count_by_one
    json = V1::LongUrlSerializer.new(@url).serialized_json
    respond_with json
  end

  def stats
    json = V1::StatsUrlSerializer.new(@url).serialized_json
    respond_with json
  end

  private

  def url_params
    params.require(:url).permit(:long)
  end

  def load_url
    short = params[:short] || params[:url_short]
    @url = Url.find_by(short: short)
  end
end
