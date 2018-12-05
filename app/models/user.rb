class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :trainings
  has_many :objectives
  has_many :runs, through: :objectives


  has_one :pending_training, -> { where(status: 'pending') }, class_name: 'Training'
end
