# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'show page', type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  before :each do
    Task.create!(title: 'Do cosc415 reading', description: 'hi :)', start: DateTime.new(2021, 11, 8),
                 due: DateTime.new(2021, 11, 11), complete: false)
    Task.create!(title: 'Do NLP homework', due: DateTime.new(2021, 11, 10), complete: false)
    Task.create!(title: 'SWE iteration 2', start: DateTime.new(2021, 11, 8), due: DateTime.new(2021, 11, 21),
                 complete: false)
    user = User.create!(email: 'testing@example.com', password: 'testtest')
    sign_in user
    visit root_path
  end

  it 'should be able to mark a task as complete' do
    click_on('Do cosc415 reading')
    click_on('Mark complete')
    click_on('Do cosc415 reading')
    expect(page).to have_button 'Mark incomplete'
  end

  it 'should be able to revert a completed task to incomplete' do
    click_on('Do cosc415 reading')
    click_on('Mark complete')
    click_on('Do cosc415 reading')
    click_on('Mark incomplete')
    click_on('Do cosc415 reading')
    expect(page).to have_button 'Mark complete'
  end
end
