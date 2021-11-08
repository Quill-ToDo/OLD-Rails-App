require 'rails_helper'

RSpec.describe "create page", type: :view do
  include Devise::Test::IntegrationHelpers

  before :each do
    @user = User.create!(email: 'admin@colgate.edu', password: 'testtest')
    sign_in @user
    visit root_path
  end

  it 'should not give the user the option to create a product if not signed in' do
    sign_out @user
    visit root_path
    expect(page).not_to have_content('Create new task')
  end

  it 'should allow a user to create a task if signed in' do
    click_on 'Create new task'
    fill_in 'Title', with: 'foo'
    fill_in 'Description', with: 'description'
    fill_in 'Start', with: DateTime.now
    fill_in 'Due', with: DateTime.now.days_ago(-5)
    click_on 'Create task'
    expect(page.current_path).to eq(root_path)
    expect(page).to have_content('New task foo created')
  end
end