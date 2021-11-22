# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tasks
  has_many :labels
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
