class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :photo, PhotoUploader

  has_one :current_objective, -> { where(status: 'current') }, class_name: 'Objective'
  has_one :current_training, -> { where(status: 'current') }, class_name: 'Training'
  has_many :objectives
  has_many :trainings
  has_many :runs, through: :objectives

  def time_targeted(race)
    if self.level == "DEBUTANT"
      if race.distance == 42_195
        return 16_200
      elsif race.distance == 21_100 || race.distance == 21_097
        return 7_800
      elsif race.distance == 10_000
        return 3_600
      end
    end
    if self.level == "REGULIER"
      if race.distance == 42_195
        return 15_000
      elsif race.distance == 21_100 || race.distance == 21_097
        return 7_200
      elsif race.distance == 10_000
        return 3_300
      end
    end
    if self.level == "EXPERT"
      if race.distance == 42_195
        return 13_800
      elsif race.distance == 21_100 || race.distance == 21_097
        return 6_300
      elif race.distance == 10_000
        return 2_700
      end
    end
  end
end
