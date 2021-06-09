require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" # show the sidekiq web UI
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
