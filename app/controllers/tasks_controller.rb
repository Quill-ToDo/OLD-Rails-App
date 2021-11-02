class TasksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # before_action :user_signed_in?, only: [:index, :new, :create]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "New task #{@task.title} created"
      redirect_to tasks_path and return
    else
      flash[:alert] = 'Failed to create new task'
      redirect_to new_tasks_path and return
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def record_not_found
      flash[:alert] = 'Task not found!'
      redirect_to products_path and return
    end

    def task_params
      params.require(:task).permit(:title, :description, :start, :due)
    end
end