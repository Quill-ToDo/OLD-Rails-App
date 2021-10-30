class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(project_params)
    if @task.save
      flash[:notice] = "New task #{@task.title} created"
      redirect_to
    # validations
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
    def set_task
      @task = Task.find(params[:id])
    end
end
