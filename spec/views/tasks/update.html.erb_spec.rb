require 'rails_helper'

RSpec.describe "update page", type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  before :all do 
    Capybara.use_default_driver
  end

  before :each do
    Task.create!(title: 'Do cosc415 reading', description: 'hi :)', start:DateTime.new(2021, 11, 8), due: DateTime.new(2021, 11, 11), complete: false)
    user = User.create!(email: 'testing@example.com', password: 'testtest')
    sign_in user
    visit root_path
    click_on('Do cosc415 reading')
    find('#btn-edit').click
  end

  it "should have correctly populated form fields" do
    expect('Title').to have_content("Do cosc415 reading")
    expect('Description').to have_content("hi :)")
    expect('Start').to have_content("2021-11-08 00:00:00 UTC")
    expect('Due').to have_content("2021-11-11 00:00:00 UTC")
    expect(page).to have_button 'Update task'  
  end

  it "should make changes the task object attributes" do
    fill_in 'Description', with: 'new description!'
    click_on('Update task')
    #expect(page.current_path).to eq(task_path(@task)) 
    expect(page).to have_content("new description!")
    #expect(@task.reload.description).to eq('new description!')
  end

end