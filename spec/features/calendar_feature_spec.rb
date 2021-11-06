require 'rails_helper'

RSpec.describe "the calendar view", type: :feature, js: true do

  before(:all) do
    Capybara.current_driver = :selenium
  end

  before :each do
    Task.create!(title: 'Do cosc415 reading', due: DateTime.new(2021, 11, 7))
    Task.create!(title: 'SWE iteration 2', start: DateTime.new(2021, 11, 8),  due: DateTime.new(2021, 11, 21))
    Task.create!(title: 'SWE iteration 3', start: DateTime.new(2021, 11, 22),  due: DateTime.new(2021, 12, 5))
    Task.create!(title: 'Physics HW', description: "boring", start: DateTime.new(2021, 11, 3),  due: DateTime.new(2021, 11, 4))
    Task.create!(title: 'Write Capybara tests', description: "not boring", start: DateTime.new(2021, 11, 3),  due: DateTime.new(2021, 11, 3))
    Task.create!(title: 'Put away christmas decorations', due: DateTime.new(2022, 01, 7))
    visit root_path
  end

  it "should show all tasks for the current month" do
    expect(page).to have_css('.fc', wait: 5)
  end

  after(:all) do
    Capybara.use_default_driver
  end
end