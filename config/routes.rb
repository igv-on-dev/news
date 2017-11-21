Rails.application.routes.draw do
  root to: "news_entries#index"

  namespace :admin do
    root to: "news_entries#new"
  end
end
