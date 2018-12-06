class Race < ApplicationRecord
  has_many :runs, dependent: :destroy
  has_many :objectives, dependent: :destroy
end
