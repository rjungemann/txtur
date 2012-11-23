Txtur::Application.routes.draw do
  resources :posts
  resources :shares
  resources :tags
  resources :stars
  resources :downloads

  root :to => 'welcome#index'
end

