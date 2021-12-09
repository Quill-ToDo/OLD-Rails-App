# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'create page', type: :view, js: true do
  include Devise::Test::IntegrationHelpers

  before :each do
    @user = User.create(email: 'admin2@colgate.edu', password: 'testtest')
    sign_in @user
    visit root_path
  end

  it 'should not give the user the option to create a task if not signed in' do
    sign_out @user
    visit root_path
    expect(current_path).to eq('/users/sign_in')
  end

  it 'should allow a user to create a task if signed in' do
    # Take out after bug fix
    dialog = page.driver.browser.switch_to.alert
    dialog.accept
    #
    find('#btn-add').click
    wait_for_ajax
    fill_in 'Title', with: 'foo'
    fill_in 'Description', with: 'description'
    fill_in 'Start', with: '11/18/2021 4:22 PM'
    fill_in 'Due', with: '11/19/2021 4:22 PM'
    click_on 'Create task'
    expect(page.current_path).to eq(root_path)
    expect(page).to have_content('New task foo created')
  end

  it 'should allow a user to create a task without a start date or description' do
    find('#btn-add').click
    fill_in 'Title', with: 'bar'
    fill_in 'Due', with: '11/19/2021 4:22 PM'
    click_on 'Create task'
    expect(page.current_path).to eq(root_path)
    expect(page).to have_content('New task bar created')
  end

  it 'should not allow a user to create a task with a start date after the due date' do
    find('#btn-add').click
    fill_in 'Title', with: 'poo'
    fill_in 'Description', with: 'description'
    fill_in 'Start', with: '11/19/2021 4:22 PM'
    fill_in 'Due', with: '11/18/2021 4:22 PM'
    click_on 'Create task'
    expect(page.current_path).to eq(new_task_path)
    expect(page).to have_content('Failed to create new task')
  end

  it 'should set start to nil if a user enters an ill-formed start date' do
    find('#btn-add').click
    fill_in 'Title', with: 'poo'
    fill_in 'Description', with: 'description'
    fill_in 'Start', with: 'asdf'
    fill_in 'Due', with: '11/18/2021 4:22 PM'
    click_on 'Create task'
    expect(page.current_path).to eq(root_path)
    expect(Task.where("title = 'poo'")[0].start).to eq(nil)
    expect(page).to have_content('New task poo created')
  end

  it 'should not allow a user to create a task with an ill-formed due date' do
    find('#btn-add').click
    fill_in 'Title', with: 'poo'
    fill_in 'Description', with: 'description'
    fill_in 'Due', with: 'asdf'
    click_on 'Create task'
    expect(page.current_path).to eq(root_path)
    expect(page).to have_content('Failed to create new task')
  end
end
