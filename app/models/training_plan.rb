class TrainingPlan < ApplicationRecord
  has_many :training_sessions
  has_many :trainings
end
