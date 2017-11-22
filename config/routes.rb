require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  root to: "news_entries#main"
  get :admin, to: "authored_news_entries#new"
  post :admin, to: "authored_news_entries#create"
  patch :admin, to: "authored_news_entries#update"
end
