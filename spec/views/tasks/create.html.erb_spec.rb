require 'rails_helper'

RSpec.describe "create page", type: :view do
  include Devise::Test::IntegrationHelpers

  before :each do
    @user = User.create(email: 'admin@colgate.edu', password: 'testtest')
    sign_in @user
    visit root_path
  end

  it 'should not give the user the option to create a task if not signed in' do
    sign_out @user
    visit root_path
    expect(current_path).to eq('/users/sign_in')
  end

  it 'should allow a user to create a task if signed in' do
    find('#btn-add').click
    fill_in 'Title', with: 'foo'
    fill_in 'Description', with: 'description'
    fill_in 'Start', with: '2021-11-12T00:00:00-05:00'
    fill_in 'Due', with: '2021-12-12T00:00:00-05:00'
    click_on 'Create task'
    expect(page.current_path).to eq(root_path)
    expect(page).to have_content('New task foo created')
  end

  it 'should allow a user to create a task without a start date or description' do
    find('#btn-add').click
    fill_in 'Title', with: 'bar'
    fill_in 'Due', with: '2021-12-12T00:00:00-05:00'
    click_on 'Create task'
    expect(page.current_path).to eq(root_path)
    expect(page).to have_content('New task bar created')
  end

  it 'should not allow a user to create a task with a start date after the due date' do
    find('#btn-add').click
    fill_in 'Title', with: 'poo'
    fill_in 'Description', with: 'description'
    fill_in 'Start', with: '2021-12-12T00:00:10-05:00'
    fill_in 'Due', with: '2021-12-12T00:00:00-05:00'
    click_on 'Create task'
    expect(page.current_path).to eq(new_task_path)
    expect(page).to have_content('Failed to create new task')
  end
end