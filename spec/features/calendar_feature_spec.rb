# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the calendar view', type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  before :each do
    user = User.create(email: 'soren.lorenson@example.com', password: 'testtest')
    sign_in user
    Task.create!(title: 'Do cosc415 reading', due: DateTime.new(2021, 11, 7), user_id: user.id)
    Task.create!(title: 'SWE iteration 2', start: DateTime.new(2021, 11, 8), due: DateTime.new(2021, 11, 21), user_id: user.id)
    Task.create!(title: 'SWE iteration 3', start: DateTime.new(2021, 11, 22), due: DateTime.new(2021, 12, 5), user_id: user.id)
    Task.create!(title: 'Physics HW', description: 'boring', start: DateTime.new(2021, 11, 3),
                 due: DateTime.new(2021, 11, 4), user_id: user.id)
    # Task.create!(title: 'Write Capybara tests', description: "not boring", start: DateTime.new(2021, 11, 3),  due: DateTime.new(2021, 11, 3))
    Task.create!(title: 'Put away christmas decorations', due: DateTime.new(2021, 11, 7), user_id: user.id)
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
    sleep(5)
    expect(page.find('#calendar')).to have_content("Task1")
  end

  it 'should add a task to the calendar after selecting a date range' do
    current_day = page.find('.fc-day-today')
    begin 
      next_day = page.find('.fc-day-today + .fc-day').native
    rescue Capybara::ElementNotFound
      next_day = current_day.first(:xpath,".//..").first(:xpath, "following-sibling::tr").first(:xpath, "child::td").native
    end
    current_day = current_day.native
    page.driver.browser.action.click_and_hold(current_day).move_to(next_day).perform
    page.driver.browser.action.release.perform
    dialog = page.driver.browser.switch_to.alert
    dialog.send_keys("Task2")
    dialog.accept
    visit root_path
    sleep(5)
    expect(page.find('#calendar')).to have_content("Task2")
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
    sleep(5)
    expect(Task.find_by(title:'Task1')).to_not eq(nil)
    expect(Task.find_by(title:'Task1').start.to_date.to_formatted_s(:db)).to eq(DateTime.now.to_date.to_formatted_s(:db))
  end 

  it "should add a task and find same task in list" do
    current_day = page.find('.fc-day-today')
    current_day.native.click
    dialog = page.driver.browser.switch_to.alert
    dialog.send_keys("Do the dishes")
    dialog.accept
    expect(find("#list-wrapper")).to have_content('Do the dishes')  
  end
end
