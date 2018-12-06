class Objective < ApplicationRecord
  belongs_to :user
  belongs_to :race
  has_many :runs, dependent: :destroy
end
