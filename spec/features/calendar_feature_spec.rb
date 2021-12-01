# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the calendar view', type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  before :each do
    user = User.create(email: 'soren.lorenson@example.com', password: 'testtest')
    sign_in user
    Task.create!(title: 'SWE iteration 2', start: DateTime.now.next, due: DateTime.now.next, user_id: user.id)
    Task.create!(title: 'SWE iteration 3', start: DateTime.now.next.next, due: DateTime.now.next.next.next, user_id: user.id)
    Task.create!(title: 'Physics HW', description: 'boring', start: DateTime.now.next, due: DateTime.now.next.next.next, user_id: user.id)
    Task.create!(title: 'Do cosc415 reading', due: DateTime.now, user_id: user.id)
    # Task.create!(title: 'Write Capybara tests', description: "not boring", start: DateTime.new(2021, 11, 3),  due: DateTime.new(2021, 11, 3))
    Task.create!(title: 'Put away christmas decorations', due: DateTime.now.next, user_id: user.id)
    visit root_path
  end

  it 'should show all tasks for the current month' do
    calendar = page.find('#calendar')
    expect(calendar).to have_content('Do cosc415 reading')
    expect(calendar).to have_content('SWE iteration 2')
    expect(calendar).to have_content('SWE iteration 3')
    expect(calendar).to have_content('Physics HW')
    expect(calendar).to have_content('Put away christmas decorations')
  end

  it 'should add a task to the calendar after clicking on a date' do
    current_day = page.find('.fc-day-today').find('.fc-daygrid-day-top')
    current_day.native.click
    dialog = page.driver.browser.switch_to.alert
    dialog.send_keys("Task1")
    dialog.accept
    visit root_path
    sleep(15)
    expect(page.find('#calendar')).to have_content("Task1")
  end

  it 'should add a task to the calendar after selecting a date range' do
    current_day = page.find('.fc-day-today').find('.fc-daygrid-day-top').native
    next_day = page.find(".fc-day-future", match: :first).native
    page.driver.browser.action.click_and_hold(current_day).move_to(next_day).perform
    page.driver.browser.action.release.perform
    dialog = page.driver.browser.switch_to.alert
    dialog.send_keys("Task2")
    dialog.accept
    visit root_path
    sleep(15)
    expect(page.find('#calendar')).to have_content("Task2")
    expect(Task.find_by(title:'Task2').start.to_date.to_formatted_s(:db)).to eq(DateTime.now.to_date.to_formatted_s(:db))
    expect(Task.find_by(title:'Task2').due.to_date.to_formatted_s(:db)).to eq(DateTime.now.to_date.tomorrow.to_formatted_s(:db))
  end

  it 'should add a newly added task to the database' do
    current_day = page.find('.fc-day-today').find('.fc-daygrid-day-top')
    current_day.native.click
    dialog = page.driver.browser.switch_to.alert
    dialog.send_keys("Task1")
    dialog.accept
    visit root_path
    sleep(15)
    expect(Task.find_by(title:'Task1')).to_not eq(nil)
    expect(Task.find_by(title:'Task1').start.to_date.to_formatted_s(:db)).to eq(DateTime.now.to_date.to_formatted_s(:db))
  end 

  it "should add a task and find same task in list" do
    current_day = page.find('.fc-day-today').find('.fc-daygrid-day-top')
    current_day.native.click
    dialog = page.driver.browser.switch_to.alert
    dialog.send_keys("Do the dishes")
    dialog.accept
    sleep(15)
    expect(find("#list-wrapper")).to have_content('Do the dishes')  
  end

  it "should update a task when a user moves an event in the calendar" do
    task_box = page.find('.fc-day-today').find('.fc-event-draggable', match: :first)
    task = task_box.find('.fc-event-title').text
    db_task = Task.find_by(title: task)
    db_task_start = db_task.start
    db_task_due = db_task.due
    next_day = page.find('.fc-day-future', match: :first).native
    page.driver.browser.action.click_and_hold(task_box.native).move_to(next_day).perform
    page.driver.browser.action.release.perform
    sleep(30)
    expect(page.find('.fc-day-future', match: :first)).to have_content(task)
    if !db_task_start.nil?
      expect(Task.find_by(title: task).start.to_date.to_formatted_s(:db)).to eq(db_task_start.to_date.tomorrow.to_formatted_s(:db))
    end
    expect(Task.find_by(title: task).due.to_date.to_formatted_s(:db)).to eq(db_task_due.to_date.tomorrow.to_formatted_s(:db))
  end
end
