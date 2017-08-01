Rails.application.routes.draw do
  
  
  resources :changelogs
  resources :searches
  devise_for :users
  resources :choices
  resources :details
require "sidekiq/web"
require "sidekiq/cron/web"
mount Sidekiq::Web=>"/sidekiq"



  resources :questions do
  	resources :performances
    resources :answers
  end
  root"questions#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
