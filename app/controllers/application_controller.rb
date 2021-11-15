# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  def after_sign_in_path_for(_resource)
    root_path
  end
end
