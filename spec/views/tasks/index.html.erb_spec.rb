require 'rails_helper'

RSpec.describe "index page", type: :view do
  
  before :each do
    Task.create!(:title => "do SWE homework", :description => "do it", :start => DateTime.now, :end => DateTime.now.days_ago(-5))
    Task.create!(:title => "do laundry", :due => DateTime.now.hours_ago(-3))
    Task.create!(:title => "finish paper", :due => DateTime.now.days_ago(-6))
    Task.create!(:title => "make dinner", :description => "pasta carbonara?", :due => DateTime.now.hours_ago(-2))

    visit "/tasks"
  end

  it "should display the titles of all tasks" do
    expect(page).to have_content("do SWE homework")
    expect(page).to have_content("do laundry")
    expect(page).to have_content("finish paper")
    expect(page).to have_content("make dinner")
  end

  it "should allow tasks to be completed" do
  end

  it "should allow completed tasks to be marked incomplete" do
  end

  it "should display overdue tasks" do
  end
end