require 'swagger_helper'

describe 'Urls API', type: :request do
  path '/v1/urls' do
    post 'Create short url' do
      tags 'URL'
      consumes 'application/json'

      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          url: {
            type: :object,
            properties: {
              long: { type: :string }
            }
          }
        },
        required: [ 'long' ]
      }

      response '201', 'created short ulr' do
        let!(:long) { '/users/1/posts/1' }
        let(:params) { { url: { long: long} } }
        let(:json) { JSON.parse(response.body) }

        run_test!
      end
    end
  end
end