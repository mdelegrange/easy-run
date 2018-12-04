class Race < ApplicationRecord
  has_many :runs
  has_many :objectives

  validates :name, presence: true, allow_blank: false
  validates :date, presence: true
  validates :distance, numericality: { greater_than: 0 }, allow_blank: false
  validates :address, presence: true, allow_blank: false
  validates :zipcode, presence: true, numericality: { only_integer: true }
  validates :city, presence: true
  validates :url, presence: true
  validates :limit_date, presence: true
end
