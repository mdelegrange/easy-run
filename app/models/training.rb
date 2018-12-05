class Training < ApplicationRecord
  belongs_to :user
  belongs_to :training_plan

  validates :begin_date, presence: true
  validates :status, inclusion: { in: ['current', 'finished', 'skipped'] }, presence: true
end
