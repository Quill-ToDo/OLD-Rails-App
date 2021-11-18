# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'index page', type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

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
end
