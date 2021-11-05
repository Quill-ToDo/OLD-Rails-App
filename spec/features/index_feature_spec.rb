require 'rails_helper'

RSpec.describe "index page", type: :feature, js: true do

  before(:all) do
    Capybara.current_driver = :selenium
  end

  before :each do
    visit root_path
  end

  it "should render the calendar view" do
    byebug
    expect(page).to have_css('#calendar')
  end

  after(:all) do
    Capybara.use_default_driver
  end
end
