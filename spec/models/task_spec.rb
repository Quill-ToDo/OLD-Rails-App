# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Task', type: :model do
  describe 'check attributes and methods' do
    it 'should be able to create a Task object which has the correct methods on it' do
      dt = DateTime.new
      @user = User.create(email: 'admin@colgate.edu', password: 'testtest')
      task = Task.create!(title: 'test', description: 'desc', start: dt.midnight, due: dt.noon, user_id: @user.id)
      expect(task).to respond_to :title
      expect(task).to respond_to :description
      expect(task).to respond_to :start
      expect(task).to respond_to :due
    end
  end

  it 'should fail to create a Task if there is no due date' do
    dt = DateTime.new
    @user = User.create(email: 'admin@colgate.edu', password: 'testtest')
    expect do
      Task.create!(title: 'test', description: 'desc', start: dt.noon, user_id: @user.id)
    end.to raise_exception ActiveRecord::RecordInvalid
  end

  it 'should fail to create a Task if maximum text inputs exceed' do
    dt = DateTime.new
    @user = User.create(email: 'admin@colgate.edu', password: 'testtest')
    expect do
      Task.create!(title: '1' * 1000, description: '1' * 10_000,
                   due: dt.noon, user_id: @user.id)
    end.to raise_exception ActiveRecord::RecordInvalid
  end
end
