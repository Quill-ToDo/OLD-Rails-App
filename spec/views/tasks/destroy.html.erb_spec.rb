# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'deleting a task', type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  before :each do
    user = User.create!(email: 'testing@example.com', password: 'testtest')

    Task.create!(title: 'Do cosc415 reading', description: 'hi :)', start: DateTime.new(2021, 11, 8),
                 due: DateTime.new(2021, 11, 11), complete: false, user_id: user)
    sign_in user
    visit root_path
    click_on('Do cosc415 reading')
    find('#btn-delete').click
  end

  it 'should successfully delete a task' do
    expect(page.current_path).to eq(root_path)
    expect(page).not_to have_content('Overdue')
    expect(page).to have_content('Do cosc415 reading deleted')
  end
end
