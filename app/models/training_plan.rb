class TrainingPlan < ApplicationRecord
  has_many :training_sessions
  has_many :trainings

  validates :name, presence: true
  validates :sessions_per_week, inclusion: { in: [1, 2, 3], allow_nil: false }, presence: true
end
