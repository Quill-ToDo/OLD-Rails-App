require 'rails_helper'
require 'jquery-rails'

RSpec.describe "index page", type: :feature do

  before :each do
    visit root_path
  end

  it "should render the calendar view" do
    # wait_until { page.find('.fc').visible? }
    # byebug
    # page.execute_script "%{ document.addEventListener('DOMContentLoaded', function() {
    #     var calendarEl = document.getElementById('calendar');
    #     var calendar = new FullCalendar.Calendar(calendarEl, {
    #       initialView: 'dayGridMonth'
    #     });
    #     calendar.render();
    #   }); }"
    byebug
    expect(page).to find('.fc-toolbar-chunk')
    byebug
  end
end
