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
        required: ['long']
      }

      let(:json) { JSON.parse(response.body) }

      response '201', 'created short ulr' do
        let!(:long) { '/users/1/posts/1' }
        let(:params) { { url: { long: long } } }

        run_test!
      end

      response '201', 'url existed' do
        let!(:long) { '/users/1/posts/1' }
        let!(:existed_url) { create(:url, long: long) }
        let(:params) { { url: { long: long } } }

        it 'returns existed url' do
          existed_short_url = "/v1/urls/#{existed_url.short}"
          expect(json['data']['attributes']['short_url']).to eq(existed_short_url)
        end

        run_test!
      end
    end
  end

  path '/v1/urls/{short}' do
    get 'Show long url' do
      tags 'URL'
      consumes 'application/json'

      parameter name: :short,
                description: 'Short url',
                in: :path,
                type: :string,
                required: true

      let(:json) { JSON.parse(response.body) }

      response '200', 'returned long url' do
        let(:long) { '/users/1/posts/1' }
        let!(:url) { create(:url, long: long) }
        let(:short) { url.short }

        it 'returns long url' do
          expect(json['data']['attributes']['long_url']).to eq(url.long)
        end

        it 'changes count of matches' do
          expect(url.reload.match).to eq(1)
        end

        run_test!
      end
    end
  end

  path '/v1/urls/{short}/stats' do
    get 'Show stats by url' do
      tags 'URL'
      consumes 'application/json'

      parameter name: :short,
                description: 'Short url',
                in: :path,
                type: :string,
                required: true

      let(:json) { JSON.parse(response.body) }

      response '200', 'returned long url' do
        let(:long) { '/users/1/posts/1' }
        let!(:url) { create(:url, long: long) }
        let(:short) { url.short }

        it 'returns stats' do
          expect(json['data']['attributes']['match']).to eq(url.match)
        end

        run_test!
      end
    end
  end
end
