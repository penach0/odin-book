Rails.application.routes.draw do
  get 'friendships/create'
  devise_for :users, controllers: { registrations: "users/registrations" }
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    root "users#index"
  end

  resources :users, only: [:index, :show] do
    resource :profile, only: [:show, :edit, :update]
    resources :posts, shallow: true
  end

  resources :friendships, only: [:create, :update, :destroy]
end
