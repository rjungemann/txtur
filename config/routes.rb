Txtur::Application.routes.draw do
  resources :posts
  resources :shares
  resources :tags
  resources :stars
  resources :downloads
  resources :feeds

  root :to => 'welcome#index'
end

