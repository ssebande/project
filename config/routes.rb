Rails.application.routes.draw do
  use_doorkeeper
  namespace :v1 do
    jsonapi_resources :users
    jsonapi_resources :organizations
    jsonapi_resources :aauctions
    jsonapi_resources :products
  end
end
