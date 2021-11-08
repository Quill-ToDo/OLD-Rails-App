Rails.application.routes.draw do
  devise_for :users
  get 'tasks', to: 'tasks#index'
  get 'tasks/index'
  get 'tasks/show'
  get 'tasks/new'
  get 'tasks/create'
  get 'tasks/edit'
  get 'tasks/update'
  get 'tasks/destroy'
  get 'tasks/get_tasks'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tasks
  root 'tasks#index'
end
