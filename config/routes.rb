Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    root "users#index"
  end

  resources :users, only: [:index, :show] do
    resource :profile, only: [:new, :create, :show, :edit, :update]
    resources :posts, shallow: true do
      resources :likes, only: [:create, :destroy]
      resources :comments, except: [:show, :index] do
        resources :comments, only: [:new, :create]
        resources :likes, only: [:create, :destroy]
      end
    end
  end

  resources :friendships, only: [:create, :update, :destroy]
end
