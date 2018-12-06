class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :photo, PhotoUploader

  has_one :current_objective, -> { where(status: 'current') }, class_name: 'Objective'
  has_one :current_training, -> { where(status: 'current') }, class_name: 'Training'
  has_many :objectives
  has_many :trainings
  has_many :runs, through: :objectives

  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false
  validates :photo, presence: true
  validates :email, uniqueness: true, presence: true, allow_blank: false
end
