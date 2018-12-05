Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # Objective creation
  resources :marathons, only: [:index] do
    resources :objectives, only: [:create]
  end
  resources :races, only: [:index] do
    resources :runs, only: [:create]
  end

  # Dashboard
  resources :objectives, only: [:index, :show] do
    resources :runs, only: [:index]
  end
  resources :runs, only: [:show, :edit, :update, :destroy] do
    member do
      patch :subscribe
      patch :skip
      patch :mark_as_done
    end
  end

  resource :training, only: [:show] do
    resources :sessions, only: [:show], module: :trainings
  end

  resource :profile, only: [:show, :edit, :update]
end
