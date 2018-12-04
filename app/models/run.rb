class Run < ApplicationRecord
  belongs_to :objective
  belongs_to :race

  validates :targeted_time, presence: true, numericality: { greater_than: 0 }
  validates :final_time, presence: true, numericality: { greater_than: 0 }
  validates :status, inclusion: { in: ['pending', 'accomplished', 'aborted'] }, presence: true
end
