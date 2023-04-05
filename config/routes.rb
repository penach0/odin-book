Rails.application.routes.draw do
  get 'friendships/create'
  devise_for :users

  devise_scope :user do
    root "users#index"
  end
  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create, :update]
  end
end
