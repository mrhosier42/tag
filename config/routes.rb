Rails.application.routes.draw do
  root to: 'semesters#home'
  devise_for :users

  resources :semesters, except: [:index] do
    get 'team', on: :member
    resources :sprints
    scope module: 'semesters' do
      resources :repositories, only: [:new, :create, :show]
      get 'github_key', to: 'pages#github_key', as: 'enter_github_key'
      post 'github_key', to: 'pages#post_github_key'
    end
  end
end
