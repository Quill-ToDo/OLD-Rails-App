class TasksController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
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
    puts events
    puts "#{Task.all.count} This is inside the controller#get_tasks method"
    render :json => events.to_json
  end
end
