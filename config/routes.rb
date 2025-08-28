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
    get 'users/search', to: 'users#search', as: 'user_search'
    resources :users, only: [:edit, :update, :show, :destroy] do
      resource :follows, only: [:create, :destroy]
          get "followings" => "follows#followings", as: "followings"
  	      get "followers" => "follows#followers", as: "followers"
      resources :reports, only: [:index]
    end
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      resources :reports, only: [:create, :destroy]
    end
    resources :favorites, only: [:index]
    resources :notifications, only: [:index, :destroy] do
      collection do
        delete :destroy_all
      end
    end
  end

  namespace :admin do
    root to: 'homes#top'
    resources :users, only: [:show, :update, :destroy]
    resources :reports, only: [:index]
    resources :posts, only: [:index, :show, :destroy] do
      resources :reports, only: [:index, :show]
    end
  end

  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
