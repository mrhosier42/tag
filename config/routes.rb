Rails.application.routes.draw do
  root to: 'semesters#home'
  devise_for :users

  resources :semesters, except: [:index] do
    get 'team', on: :member
    resources :sprints
    scope module: 'semesters' do # controllers/semesters/*
      resources :semesters do
        resources :repositories, only: [:new, :create, :show], module: :semesters
        resources :sprints, only: [:index, :new, :create, :edit, :update, :destroy], module: :semesters
        get 'github_key', to: 'pages#github_key', as: 'enter_github_key'
        post 'github_key', to: 'pages#post_github_key'
        get ':id/team', to: 'semesters#team', as: 'team'
      end

    end
  end
end
