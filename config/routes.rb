Txtur::Application.routes.draw do
  resources :posts
  resources :shares
  resources :tags
  resources :stars

  root :to => 'welcome#index'
end

