Rails.application.routes.draw do
  devise_scope :user do
    root "users#index"
  end

  devise_for :users
  resources :users, only: [:index, :show]
end
