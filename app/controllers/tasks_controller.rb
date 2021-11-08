class TasksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # before_action :user_signed_in?, only: [:index, :new, :create]

  def index
    @overdue = Task.order('due DESC').where('due < ?', DateTime.now)
    @today_due = Task.order('due DESC').where('due >= ?', Date.today).where('due < ?', Date.tomorrow)
    @today_work = Task.order('due DESC').where('start <= ?', Date.today).where('due >= ?', Date.tomorrow)
    @upcoming = Task.order('due DESC').where('start > ?', Date.today).or(Task.order('due DESC').where('start IS NULL').where('due >= ?', Date.tomorrow))
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
      redirect_to tasks_new_path and return
    end
  end

  def show
    @task = Task.find(params[:id])
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
    @task = Task.find(params[:id])
    @task.destroy
    flash[:alert] = "#{@task.title} deleted"
    redirect_to tasks_path
  end

  def get_tasks
    @tasks = Task.all.where('due <= ?', Time.at(params['end'].to_datetime).to_formatted_s(:db)).or(Task.all.where('due <= ?', Time.at(params['end'].to_datetime).to_formatted_s(:db)).where('start >= ?', Time.at(params['start'].to_datetime).to_formatted_s(:db)))
    events = []
    @tasks.each do |task|
      h = Hash.new()
      h[:id] = task.id
      h[:title] = task.title

      unless task.description.nil?
        h[:description] = task.description
      end

      if task.start.nil?
        h[:start] = DateTime.iso8601(task.due.iso8601).next.iso8601
      else
        h[:start] = DateTime.iso8601(task.start.iso8601).next.iso8601
      end

      h[:end] = DateTime.iso8601(task.due.iso8601).next.iso8601
      events << h
    end
    render :json => events.to_json
  end

  def complete_task
    t = Task.find(params[:id])
    t.complete_task
    t.save
    redirect_to root_path
  end

  private
    def record_not_found
      flash[:alert] = 'Task not found!'
      redirect_to tasks_path and return
    end

    def task_params
      p = params.require(:task).permit(:title, :description, :start, :due)
      h = p.to_hash
      if h.include?('start')
        begin
          h[:start] = DateTime.parse(h['start'])
        rescue ArgumentError
          h[:start] = nil
        end
      end
      if h.include?('due')
        begin
          h[:due] = DateTime.parse(h['due'])
        rescue ArgumentError
          return
        end
      end
      params = ActionController::Parameters.new(h).permit(:title, :description, :start, :due)
    end
end
