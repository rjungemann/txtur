Txtur::Application.routes.draw do
  resources :posts
  resources :shares
  resources :tags
  resources :stars
  resources :downloads
  resources :feeds
  resources :imports

  root :to => 'welcome#index'
end

