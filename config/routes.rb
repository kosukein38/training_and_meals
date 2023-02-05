Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  root to: 'static_pages#top'
  get 'privacy', to: 'static_pages#privacy'
  get 'terms', to: 'static_pages#terms'
  get 'contact', to: 'static_pages#contact'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[show new create] do
    member do
      get :followings, :followers
    end
  end
  resources :relationships, only: %i[create destroy]
  resource :profile, only: %i[show edit update destroy]
  resources :workouts
  resources :meals
  get 'calorie_search', to: 'meals#calorie_search'
  get 'date_search', to: 'users#date_search'
  get 'sitemap', to: redirect("https://s3-ap-northeast-1.amazonaws.com/#{Rails.application.credentials.aws[:s3][:bucket]}/sitemaps/sitemap.xml.gz")
  resources :password_resets, only: %i[new create edit update]
end
