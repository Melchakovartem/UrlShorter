module UrlShorterService
    class << self
      def call(params)
        url = Url.find_or_create_by(long: params[:long], short: generate_short_url)
      end

      private

      def generate_short_url
        array_of_symbols = ((0..9).to_a + ('a'..'z').to_a)
        Array.new(20).map { array_of_symbols.sample }.join
      end
    end
  end