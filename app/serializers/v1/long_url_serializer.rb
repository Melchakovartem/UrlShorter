class V1::LongUrlSerializer < V1::BaseSerializer
  attributes :long_url

  attribute :long_url do |object|
    object.long
  end
end