Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, only: %i[new create]
  resources :boards do
    resources :comments, shallow: true
    collection do
      get :bookmarks
    end
  end
  resources :bookmarks, only: %i[create destroy]
  resources :password_resets, only: %i[new create edit update]
  resource :profile, only: %i[show edit update]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  # Defines the root path route ("/")
  # root "articles#index"
  root "static_pages#top"
    
  namespace :admin do
    root to: 'dashboards#index'
    resource :dashboard, only: %i[index]
    resources :users, only: %i[index show edit update destroy]
    resources :boards, only: %i[index show edit update destroy]
    get 'login', to: 'user_sessions#new', :as => :login
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy', :as => :logout
  end
end