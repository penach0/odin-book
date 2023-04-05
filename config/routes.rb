Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root "users#index"
  end
  resources :users, only: [:index, :show]
end
