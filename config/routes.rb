# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq' # show the sidekiq web UI at localhost/sidekiq
  get '/movies/:title' => 'movies#show'

  resources :movies
end
