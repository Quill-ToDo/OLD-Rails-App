# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'index page', type: :view do
  include Devise::Test::IntegrationHelpers

  before :each do
    Task.create!(title: 'do SWE homework', description: 'do it', start: DateTime.new(2021, 11, 7),
                 due: DateTime.new(2021, 11, 8))
    Task.create!(title: 'do laundry', due: DateTime.new(2021, 11, 5))
    Task.create!(title: 'finish paper', due: DateTime.new(2021, 11, 11))
    Task.create!(title: 'make dinner', description: 'pasta carbonara?', due: DateTime.new(2021, 11, 10))
    @user = User.create(email: 'admin@colgate.edu', password: 'testtest')
    sign_in @user
    visit root_path
  end

  it 'should display the titles of all tasks' do
    expect(page).to have_content('do SWE homework')
    expect(page).to have_content('do laundry')
    expect(page).to have_content('finish paper')
    expect(page).to have_content('make dinner')
  end

  it 'should display overdue tasks'
  # it "should not display overdue completed tasks"
end
