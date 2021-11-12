Rails.application.routes.draw do
  root 'tasks#index'
  devise_for :users
  get 'tasks/get_tasks'
  post 'tasks/complete_task'
  # Custom routes for tasks should go above this point ^^^ (Above resources :tasks)
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
