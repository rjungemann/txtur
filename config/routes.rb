Txtur::Application.routes.draw do
  resources :posts
  resources :shares

  root :to => 'welcome#index'
end

