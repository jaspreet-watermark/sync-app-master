require 'sidekiq/web'

Rails.application.routes.draw do
  # API routes
  mount API::Base, at: API::Base::PREFIX
  mount GrapeSwaggerRails::Engine => '/swagger'
  mount Sidekiq::Web => '/sidekiq'
end
