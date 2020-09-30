class V1::ShortUrlSerializer < V1::BaseSerializer
  attributes :short_url

  attribute :short_url do |object|
    "/v1/urls/#{object.short}"
  end
end
