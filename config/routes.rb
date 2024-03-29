Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  root 'top#index'
  resources :users do
    member do
      get :likes
    end
  end
  resources :ski_resorts do
    resources :reviews
    collection do
      get 'search'
    end
    resources :likes, only: [:create, :destroy]
  end
end
