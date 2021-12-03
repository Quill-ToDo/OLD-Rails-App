# Tasks Controller
class TasksController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # before_action :user_signed_in?, only: [:index, :new, :create]

  def index
    @overdue = overdue_tasks
    @today_due = today_due_tasks
    @today_work = today_work_tasks
    @upcoming = upcoming_tasks
  end

  def update_partials
    @overdue = overdue_tasks
    @today_due = today_due_tasks
    @today_work = today_work_tasks
    @upcoming = upcoming_tasks
    respond_to do |format|
      format.js do
        render action: 'update_partials' and return
      end
      format.html do
        redirect_to root_path
      end
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id if @task.user_id.nil?
    if @task.save
      flash[:notice] = "New task #{@task.title} created"
      redirect_to root_path and return
    else
      flash[:alert] = 'Failed to create new task'
      redirect_to new_task_path and return
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
    # byebug
    if @task.update(task_params)
      # byebug
      flash[:notice] = "Task #{@task.title} successfully updated"
      return if params['task'].include?('calendar')
      redirect_to task_path(@task)
    else
      # byebug
      # save failed
      flash[:alert] = "Task couldn't be updated"
      render 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:alert] = "#{@task.title} deleted"
    redirect_to root_path
  end

  def calendar_tasks
    @tasks = Task.all.where('user_id = ?', current_user.id)
                 .where('due <= ?', DateTime.parse(params['end']))
                 .or(Task.all.where('user_id = ?', current_user.id)
                             .where('due <= ?', DateTime.parse(params['end']))
                             .where('start >= ?', DateTime.parse(params['start'])))
    events = []
    @tasks.each do |task|
      h = {}
      h[:id] = task.id
      h[:title] = task.title

      h[:description] = task.description unless task.description.nil?

      h[:start] = if task.start.nil?
                    task.due.to_datetime.iso8601
                  else
                    task.start.to_datetime.iso8601
                  end

      h[:end] = task.due.to_datetime.iso8601
      events << h
    end
    render json: events.to_json
  end

  def complete_task
    t = Task.find(params[:id])
    t.complete_task
    t.save
    redirect_to root_path
  end

  private

  def date_formatter(to_format)
    DateTime.strptime(to_format, "%m/%d/%Y %I:%M %p")
  rescue
    DateTime.parse(to_format)
  end

  def overdue_tasks
    Task.order('due ASC')
        .where('user_id = ?', current_user.id)
        .where('due < ?', DateTime.now.to_date.to_formatted_s(:db))
  end

  def today_due_tasks
    Task.order('due DESC')
        .where('user_id = ?', current_user.id)
        .where('due >= ?', DateTime.now.to_date.to_formatted_s(:db))
        .where('due < ?', DateTime.now.to_date.tomorrow.to_formatted_s(:db))
  end

  def today_work_tasks
    Task.order('due DESC')
        .where('user_id = ?', current_user.id)
        .where('start < ?', DateTime.now.to_date.tomorrow.to_formatted_s(:db))
        .where('due >= ?', DateTime.now.to_date.tomorrow.to_formatted_s(:db))
  end

  def upcoming_tasks
    Task.order('due DESC')
        .where('user_id = ?', current_user.id)
        .where('start >= ?', DateTime.now.to_date.tomorrow.to_formatted_s(:db))
        .or(Task.order('due DESC').where('start IS NULL')
                            .where('user_id = ?', current_user.id)
                            .where('due >= ?', DateTime.now.to_date.tomorrow.to_formatted_s(:db)))
  end

  def record_not_found
    flash[:alert] = 'Task not found!'
    redirect_to root_path and return
  end

  def task_params
    p = params.require(:task).permit(:title, :description, :start, :due, :calendar, :update)
    h = p.to_hash
    # byebug
    if h.include?('start') && h['start'] != ''
      # byebug
      begin
        h['start'] = date_formatter(h['start'])
      rescue ArgumentError
        h['start'] = nil
      end
    end
    if h.include?('due') && h['due'] != ''
      # byebug
      begin
        h['due'] = if !h.include?('calendar') || h.include?('update')
                     if h['due'] == ''
                       h['start']
                       
                     else
                       date_formatter(h['due'])
                       
                     end
                   else
                     DateTime.parse(h['due']).yesterday
                     
                   end
        # if !h.include?('calendar') || h.include?('update')
        #   if h['due'] == ''
        #     h['due'] = h['start']
        #     byebug
        #   else
        #     h['due'] = date_formatter(h['due'])
        #     byebug
        #   end
        # else
        #   h['due'] = DateTime.parse(h['due']).yesterday
        #   byebug
        # end
      rescue ArgumentError
        return
      end
    end
    h = h.except!('calendar', 'update')
    ActionController::Parameters.new(h).permit(:title, :description, :start, :due)
  end
end
