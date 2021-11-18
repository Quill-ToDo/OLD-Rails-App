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
    expect(page).to have_content("Task1")
  end

  it 'should add a newly added task to the database' do
    current_day = page.find('.fc-day-today')
    current_day.native.click
    dialog = page.driver.browser.switch_to.alert
    dialog.send_keys("Task1")
    dialog.accept
    visit root_path
    expect(Task.find_by(title:'Task1')).to_not eq(nil)
  end 
end
