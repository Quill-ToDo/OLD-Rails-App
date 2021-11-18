# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'

RSpec.describe 'Tasks', type: :request do
  include Devise::Test::IntegrationHelpers

  before :each do
    user = User.create!(:email => 'soren.lorenson@example.com', :password => 'testtest')
    sign_in user
    visit root_path
  end

  #   describe "GET /index" do
  #     it "returns http success" do
  #       byebug
  #       get "/tasks/index"
  #       byebug
  #       expect(response).to have_http_status(:success)
  #     end
  #   end

  #   describe "GET /new" do
  #     it "returns http success" do
  #       get "/tasks/new"
  #       expect(response).to have_http_status(:redirect)
  #     end
  #   end

  #   describe "GET /create" do
  #     it "returns http redirect" do
  #       t = Task.new(title: 'Do cosc415 reading', due: DateTime.new)
  #       # expect(TasksController).to receive(:task_params).and_return({})
  #       expect(Task).to receive(:new).and_return(t)
  #       get "/tasks/create", params: {:task => {:title => 'Do cosc415 reading', :due => '2021-12-12T00:00:00-05:00'.to_datetime}}
  #       expect(response).to have_http_status(:redirect)
  #     end
  #   end

  #   describe "GET /show" do
  #     it "returns http success" do
  #       get "/tasks/show"
  #       expect(response).to have_http_status(:success)
  #     end
  #   end

  #   describe "GET /edit" do
  #     it "returns http success" do
  #       get "/tasks/edit"
  #       expect(response).to have_http_status(:success)
  #     end
  #   end

  #   describe "GET /update" do
  #     it "returns http success" do
  #       get "/tasks/update"
  #       expect(response).to have_http_status(:success)
  #     end
  #   end

  #   describe "GET /destroy" do
  #     it "returns http success" do
  #       get "/tasks/destroy"
  #       expect(response).to have_http_status(:success)
  #     end
  #   end

  #   describe "GET /get_tasks" do
  #     it "responds with JSON" do
  #       get "/tasks/get_tasks", params: {:start => '2021-10-31T00:00:00-04:00', :end => '2021-12-12T00:00:00-05:00'}
  #       expect(response).to have_http_status(:success)
  #       expect(response['Content-Type']).to eq("application/json; charset=utf-8")
  #     end

  #     it "returns all tasks in JSON format" do
  #       get "/tasks/get_tasks", params: {:start => '2021-10-31T00:00:00-04:00', :end => '2021-12-12T00:00:00-05:00'}
  #       #TO DO
  #     end
  #   end

  describe 'record_not_found behaves appropriately' do
    it 'should return to the main tasks view if a nonexistent task is searched for' do
      visit '/tasks/99999'
      expect(page.current_path).to eq(root_path)
      expect(page).to have_content('Task not found!')
    end
  end
end
