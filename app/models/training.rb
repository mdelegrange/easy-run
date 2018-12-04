class Training < ApplicationRecord
  belongs_to :user
  belongs_to :training_plan

  validates :begin_date, presence: true
  validates :status, inclusion: { in: ['pending', 'accomplished', 'aborted'] }, presence: true
end
