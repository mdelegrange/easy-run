class Run < ApplicationRecord
  belongs_to :objective
  belongs_to :race

  validates :status, inclusion: { in: %w(pending_subscription subscribed skipped finished) }
end
