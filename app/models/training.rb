class Training < ApplicationRecord
  belongs_to :user
  belongs_to :training_plan
end
