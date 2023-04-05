Rails.application.routes.draw do
  get 'friendships/create'
  devise_for :users, controllers: { registrations: "users/registrations" }

  devise_scope :user do
    root "users#index"
  end

  resources :users, only: [:index, :show] do
    resources :friendships, only: [:create, :update]
    resource :profile, only: [:show, :edit, :update]
  end
end
