Rails.application.routes.draw do
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about', as: 'about'

  namespace :admin do
    root to: 'homes#top'
    resources :posts, only: [:index, :destroy]
    resources :users, only: [:show, :destroy]
    resources :reports, only: [:create, :destroy]
  end

  namespace :public do
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
