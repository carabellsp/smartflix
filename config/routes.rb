require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq" # show the sidekiq web UI
end
