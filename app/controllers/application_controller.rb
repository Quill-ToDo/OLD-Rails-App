# module for user access
module Current
  thread_mattr_accessor :user
end

# Application Controller
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  around_action :set_current_user

  def set_current_user
    Current.user = current_user
    yield
  ensure
    Current.user = nil
  end
end
