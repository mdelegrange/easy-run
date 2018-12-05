class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :current_objective, -> { where(status: 'current') }, class_name: 'Objective'
  has_many :objectives
  has_many :trainings
  has_many :runs, through: :objectives
end
