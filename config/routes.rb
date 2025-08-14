Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'public/users/registrations',
    sessions: 'public/users/sessions'
  },
  path: 'users', path_names: {
    sign_in: 'sign_in',
    sign_out: 'sign_out',
    sign_up: 'sign_up'
  }

  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  },
  path: 'admin', path_names: {
    sign_in: 'sign_in',
    sign_out: 'sign_out'
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/users/sessions#guest_sign_in'
  end

  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end

  namespace :admin do
    root to: 'homes#top'
  end

  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
