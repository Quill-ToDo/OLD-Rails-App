# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.feature 'Login redirect', type: :feature do
  scenario 'Visiting without login' do
    visit '/'
    expect(page).to have_current_path('/users/sign_in')
  end
end
