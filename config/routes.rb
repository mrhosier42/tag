Rails.application.routes.draw do
  root to: 'semesters#home'
  devise_for :users
  # resources :sprints

  # Semester controller
  get 'semesters', to: 'semesters#home', as: 'semesters'
  post 'semesters', to: 'semesters#create'
  get 'semesters/new', to: 'semesters#new', as: 'new_semester'
  get 'semesters/:id/edit', to: 'semesters#edit', as: 'edit_semester'
  get 'semesters/:id', to: 'semesters#show', as: 'semester'
  patch 'semesters/:id', to: 'semesters#update'
  delete 'semesters/:id', to: 'semesters#destroy'
  get 'semesters/:semester_id/team/', to: "semesters#team", as: 'semester_team'

  # Sprint controller
  get 'semesters/:semester_id/sprints', to: 'sprints#index', as: 'semester_sprints'
  post 'semesters/:semester_id/sprints', to: 'sprints#create'
  get 'semesters/:semester_id/sprints/new', to: "sprints#new", as: 'new_semester_sprint'
  get 'semesters/:semester_id/sprints/:id', to: 'sprints#show', as: 'semester_sprint'
  patch 'semesters/:semester_id/sprints/:id', to: 'sprints#update'
  delete 'semesters/:semester_id/sprints/:id', to: 'sprints#destroy'
  put 'semesters/:semester_id/sprints/:id', to: 'sprints#update'
  get 'semesters/:semester_id/sprints/:id/edit', to: 'sprints#edit', as: 'edit_semester_sprint'

  # Repository controller
  get 'semesters/:semester_id/repositories/new', to: 'repositories#new', as: 'post_new_repository'
  post 'semesters/:semester_id/repositories', to: 'repositories#create', as: 'create_new_repository'
  get 'semesters/:semester_id/repositories/show', to: 'repositories#show', as: 'show_repository'

  # Page controller
  get 'semesters/:semester_id/github_key', to: 'pages#github_key', as: 'enter_github_key'
  post 'semesters/:semester_id/github_key', to: 'pages#post_github_key'
end

# TODO: Simplify routes to make it easier to manage
# Rails.application.routes.draw do
#
#   root to: 'semesters#home'
#   devise_for :users
#
#   resources :semesters, except: [:index] do
#     get 'team', on: :member
#     resources :sprints
#     scope module: 'semesters' do # controllers/semesters/*
#       resources :semesters do
#         resources :repositories, only: [:new, :create, :show], module: :semesters
#         resources :sprints, only: [:index, :new, :create, :edit, :update, :destroy], module: :semesters
#         get 'github_key', to: 'pages#github_key', as: 'enter_github_key'
#         post 'github_key', to: 'pages#post_github_key'
#         get ':id/team', to: 'semesters#team', as: 'team'
#       end
#
#     end
#   end
# end
