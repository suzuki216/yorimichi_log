Rails.application.routes.draw do
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
