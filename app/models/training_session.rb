class TrainingSession < ApplicationRecord
  belongs_to :training_plan

  validates :description, presence: true
  validates :position, numericality: { greater_than: 0 }, presence: true
end
