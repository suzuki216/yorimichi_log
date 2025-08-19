Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
    registrations: 'public/users/registrations',
    sessions: 'public/users/sessions'
  },
  path: 'users', path_names: {
    sign_in: 'sign_in',
    sign_out: 'sign_out',
    sign_up: 'sign_up'
  }

  devise_for :admin, skip: [:registration, :passwords],controllers: {
    sessions: 'admin/sessions'
  },
  path: 'yorimichi', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/users/sessions#guest_sign_in'
  end

  namespace :public do
    get 'homes/top'
    get 'homes/about'
    get 'mypage', to: 'users#mypage'
    resources :users, only: [:edit, :update, :show, :destroy]
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :post_images, only: [:destroy]
    end
  end

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:show, :update, :destroy]
  end

  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
