# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the calendar view', type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  before :each do
    user = User.create(email: 'soren.lorenson@example.com', password: 'testtest')
    sign_in user
    Task.create!(title: 'Do cosc415 reading', due: DateTime.parse(DateTime.now.to_date.to_formatted_s(:db)))
    Task.create!(title: 'SWE iteration 2', start: DateTime.parse(DateTime.now.to_date.to_formatted_s(:db)), due: DateTime.parse(DateTime.now.to_date.tomorrow.to_formatted_s(:db)))
    Task.create!(title: 'SWE iteration 3', start: DateTime.parse(DateTime.now.to_date.yesterday.to_formatted_s(:db)), due: DateTime.parse(DateTime.now.to_date.yesterday.to_formatted_s(:db)))
    Task.create!(title: 'Physics HW', description: 'boring', start: DateTime.parse(DateTime.now.to_date.yesterday.to_formatted_s(:db)),
                 due: DateTime.parse(DateTime.now.to_date.tomorrow.to_formatted_s(:db)))
    Task.create!(title: 'Put away christmas decorations', due: DateTime.parse(DateTime.now.to_date.tomorrow.to_formatted_s(:db)))
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
    current_day = page.find('.fc-day-today')
    current_day.native.click
    dialog = page.driver.browser.switch_to.alert
    dialog.send_keys("Task1")
    dialog.accept
    visit root_path
    sleep(2)
    expect(page).to have_content("Task1")
  end

  it 'should add a task to the calendar after selecting a date range' do
    current_day = page.find('.fc-day-today').native
    next_day = page.find('.fc-day-today + .fc-day').native
    page.driver.browser.action.click_and_hold(current_day).move_to(next_day).perform
    page.driver.browser.action.release.perform
    dialog = page.driver.browser.switch_to.alert
    dialog.send_keys("Task2")
    dialog.accept
    visit root_path
    sleep(2)
    expect(page).to have_content("Task2")
    expect(Task.find_by(title:'Task2').start.to_date.to_formatted_s(:db)).to eq(DateTime.now.to_date.to_formatted_s(:db))
    expect(Task.find_by(title:'Task2').due.to_date.to_formatted_s(:db)).to eq(DateTime.now.to_date.tomorrow.to_formatted_s(:db))
  end

  it 'should add a newly added task to the database' do
    current_day = page.find('.fc-day-today')
    current_day.native.click
    dialog = page.driver.browser.switch_to.alert
    dialog.send_keys("Task1")
    dialog.accept
    visit root_path
    sleep(2)
    expect(Task.find_by(title:'Task1')).to_not eq(nil)
    expect(Task.find_by(title:'Task1').start.to_date.to_formatted_s(:db)).to eq(DateTime.now.to_date.to_formatted_s(:db))
  end
end
