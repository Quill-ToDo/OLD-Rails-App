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
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(create_update_params)
      flash[:notice] = "Task #{@task.title} successfully updated"
      redirect_to task_path(@task)
    else
      # save failed
      flash[:alert] = "Task couldn't be updated"
      render 'edit'
    end
  end

  def create_update_params
    params.require(:task).permit(:title, :description, :start, :due)
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