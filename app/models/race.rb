class Race < ApplicationRecord
  has_many :runs
  has_many :objectives
end
