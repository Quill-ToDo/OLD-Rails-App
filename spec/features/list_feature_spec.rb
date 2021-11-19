# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'task list', type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  before :each do
    Task.create!(title: 'Complete task', start: DateTime.new(2021, 11, 8), due: DateTime.new(2021, 11, 11),
                 complete: true)
    Task.create!(title: 'Task 2', due: DateTime.new(2021, 11, 10), complete: false)
    Task.create!(title: 'Task 3', start: DateTime.new(2021, 11, 8), due: DateTime.new(2021, 11, 21),
                 complete: false)
    user = User.create!(email: 'testing@example.com', password: 'testtest')
    sign_in user
    visit root_path
  end

  it 'should render completed tasks tick boxes as selected' do
    expect(find_field('Complete task', type: 'checkbox', visible: false).checked?)
  end

  it 'should not render uncompleted tick boxes as selected' do
    expect(!find_field('Task 2', type: 'checkbox',
                                 visible: false).checked? && !find_field('Task 3', type: 'checkbox',
                                                                                   visible: false).checked?)
  end

  it 'should allow users to complete tasks by clicking on them' do
    field = find_field('Task 2', type: 'checkbox', visible: false)
    id = field.native.attribute('data-task-id')
    field.check
    # Clicking the actual check box under should change the state of the task
    expect(Task.find(id).complete).to eq(true)
  end

  it 'should allow users to uncomplete tasks by clicking on them' do
    field = find_field('Complete task', type: 'checkbox', visible: false)
    id = field.native.attribute('data-task-id')
    field.uncheck
    expect(Task.find(id).complete).to eq(false)
  end

  it 'should update partials update_partials is called' do
    Task.create!(title: 'Task 4', due: DateTime.new(2021, 11, 10), complete: false)
    tasks_update_partials_path
    expect(page).to have_content('Task 4')
  end

  it 'should update calendar when a task is added' do
    pending "add a task and find same task in calendar"
  end
end
