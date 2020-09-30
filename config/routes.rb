Rails.application.routes.draw do
  api_version(:module => "V1", :path => {:value => "v1"}, :defaults => {:format => "json"}) do
    resources :urls, only: [:create, :show], param: :short do
      get :stats
    end
  end
end
