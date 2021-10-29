Rails.application.routes.draw do
  devise_for :users
  get 'tasks/index'
  get 'tasks/new'
  get 'tasks/create'
  get 'tasks/show'
  get 'tasks/edit'
  get 'tasks/update'
  get 'tasks/destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :tasks
  root 'tasks#index'
end
