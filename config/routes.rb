Txtur::Application.routes.draw do
  resources :posts
  resources :shares
  resources :tags

  root :to => 'welcome#index'
end

