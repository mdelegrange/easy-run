Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # Objective creation

  resources :races, only: [:index, :show] do
    resources :runs, only: [:create]
    resources :objectives, only: [:create]
  end

  # Dashboard
  resources :objectives, only: [:index, :show] do
    resources :runs, only: [:index, :new]
  end

  resources :runs, only: [:show, :edit, :update, :destroy] do
    member do
      patch :subscribe
      patch :skip
      patch :mark_as_done
    end
  end

  resource :training, only: [:show, :create] do
    resources :sessions, only: [:show], module: :trainings
  end

  resource :profile, only: [:show, :edit, :update] do
    member do
      get :quiz_form
      patch :quiz
    end
  end
end
