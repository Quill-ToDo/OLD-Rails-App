require 'rails_helper'

RSpec.describe "deleting a task", type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  before :each do
    Task.create!(title: 'Do cosc415 reading', description: 'hi :)', start:DateTime.new(2021, 11, 8), due: DateTime.new(2021, 11, 11), complete: false)
    user = User.create!(email: 'testing@example.com', password: 'testtest')
    sign_in user
    visit root_path
    click_on('Do cosc415 reading')
    find('#btn-delete').click
  end

  it "should successfully delete a task" do
    expect(page.current_path).to eq(root_path) 
    expect(page).not_to have_content("Overdue")
    expect(page).to have_content("Do cosc415 reading deleted")
  end

end
