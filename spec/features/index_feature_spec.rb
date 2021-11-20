# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'index page', type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  describe 'for a logged out user' do
    it 'should redirect users to index after sign in' do
      visit root_path 
      # TODO this will need to be removed after we fix the issue with tasks not being loaded in
      wait_for_ajax
      dialog = page.driver.browser.switch_to.alert
      dialog.accept
      # ---
      expect(current_path).to eq(new_user_session_path)  
      email = 'beepbeep@beep.com'
      pass = 'beepbeep'
      user = User.create(email: email, password: pass)
      fill_in 'Email', with: email
      fill_in 'Password',	with: pass 
      click_on 'Log in'
      expect(current_path).to eq(root_path)  
    end
  end

  describe 'for a logged in user' do
    before :each do
      user = User.create(email: 'soren.lorenson@example.com', password: 'testtest')
      sign_in user
      visit root_path
    end
  
    it 'should render the calendar partial' do
      expect(page).to have_css('#calendar')
    end
  
    it 'should render the calendar view' do
      expect(page).to have_css('.fc')
    end
  
    it 'should fail to create a Task if an invalid due date format is provided' do
      find("#btn-add").click 
      fill_in 'Title', with: 'Beep beep!'
      fill_in 'Due', with: 'Is that my bessie in a tessie?'
      click_on 'Create task'
      expect(current_path).to eq(new_task_path)
      expect(find('p.alert', visible: false).visible?)
    end
  end
end
