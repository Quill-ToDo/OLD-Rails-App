# frozen_string_literal: true

Rails.application.routes.draw do
  root 'tasks#index'
  devise_for :users
  get 'tasks/calendar_tasks'
  get 'tasks/list'
  post 'tasks/complete_task'
  # Custom routes for tasks should go above this point ^^^ (Above resources :tasks)
  resources :tasks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
