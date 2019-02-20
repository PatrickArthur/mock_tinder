Rails.application.routes.draw do
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', registration: 'register', sign_up: 'cmon_let_me_in' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#edit"

  resources :users, only: [:index, :edit] do
    resources :conversations, only: [:index,]
    resources :activity_feed, only: [:index]
  end

  resources :conversations, only: [:show]

  resources :pictures, only: [:index]

  namespace :api, defaults: { format: 'json' } do
    resources :pictures, only: [:index, :show] do
      resources :likes, only: [:create]
      resources :votes, only: [:create]
    end
    resources :users, only: [:show, :update] do
      resources :conversations, only: [:index]
      resources :pictures, only: [:create]
      resources :activity_feed, only: [:index]
    end
    resources :conversations, only: [:show] do
      resources :messages, only: [:create]
    end
  end
end
