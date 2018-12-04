class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :pending_objective, -> { where(status: 'pending') }, class_name: 'Objective'
  has_many :objectives
  has_many :trainings
  has_many :runs, through: :objectives
end
