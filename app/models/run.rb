class Run < ApplicationRecord
  attr_accessor :final_hours, :final_minutes, :final_seconds

  belongs_to :objective
  belongs_to :race

  validates :status, inclusion: { in: %w(pending_subscription subscribed skipped finished) }
end
