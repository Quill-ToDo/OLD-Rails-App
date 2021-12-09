# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'show page', type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  before :each do
    user = User.create!(email: 'testing@example.com', password: 'testtest')

    Task.create!(title: 'Do cosc415 reading', description: 'hi :)', start: DateTime.new(2021, 11, 8),
                 due: DateTime.new(2021, 11, 11), complete: false, user_id: user.id)
    Task.create!(title: 'Do NLP homework', due: DateTime.new(2021, 11, 10), complete: false, user_id: user.id)
    Task.create!(title: 'SWE iteration 2', start: DateTime.new(2021, 11, 8), due: DateTime.new(2021, 11, 21),
                 complete: false, user_id: user.id)
    sign_in user
    visit root_path
  end

  it 'should be able to mark a task as complete' do
    click_on('Do cosc415 reading')
    wait_for_ajax
    find(id: "show-wrapper").find_field('Do cosc415 reading', type: 'checkbox', visible: false).click
    expect(find(id: "show-wrapper").find_link('Do cosc415 reading')['complete'] == "")
  end

  it 'should be able to revert a completed task to incomplete' do
    click_on('Do cosc415 reading')
    wait_for_ajax
    find(id: "show-wrapper").find_field('Do cosc415 reading', type: 'checkbox', visible: false).click
    find(id: "show-wrapper").find_field('Do cosc415 reading', type: 'checkbox', visible: false).click
    expect(find(id: "show-wrapper").find_link('Do cosc415 reading')['complete'].nil?)
  end
end
