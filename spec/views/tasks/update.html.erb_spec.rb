# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'update page', type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  before :each do
    user = User.create!(email: 'testing@example.com', password: 'testtest')
    Task.create!(title: 'Do cosc415 reading', description: 'hi :)', start: DateTime.new(2021, 11, 8),
                 due: DateTime.new(2021, 11, 11), complete: false, user_id: user.id)
    sign_in user
    visit root_path
    click_on('Do cosc415 reading')
    find('#btn-edit').click
  end

  it 'should have correctly populated form fields' do
    expect(page).to have_field('Title', with: 'Do cosc415 reading')
    expect(page).to have_field('Description', with: 'hi :)')
    expect(page).to have_field('Start', with: 'November 08, 2021 12:00 AM')
    expect(page).to have_field('Due', with: 'November 11, 2021 12:00 AM')
    expect(page).to have_button 'Update task'
  end

  it 'should not update if start date is changed to after the due date' do
    # fill_in 'Start', with: '11/15/21 12:00 AM'
    page.execute_script("$('#datetimepicker1').datepicker('setDate', '11/15/21')")
    byebug
    click_on('Update task')
    expect(page).to have_content("Task couldn't be updated")
  end
end
