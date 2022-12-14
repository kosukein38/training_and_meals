Rails.application.routes.draw do
  root to: 'static_pages#top'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[show new create]
  resource :profile, only: %i[show edit update destroy]
  resources :workouts
  resources :meals
  get 'calorie_search', to: 'meals#calorie_search'
  get 'date_search', to: 'users#date_search'
end
