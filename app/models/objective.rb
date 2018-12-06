class Objective < ApplicationRecord
  belongs_to :user
  belongs_to :race
  has_many :runs

  validates :kind, presence: true
  validates :duration, presence: true, numericality: { greater_than: 0 }
  validates :distance, presence: true, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: ['current', 'achieved', 'unachieved'] }, presence: true
end
