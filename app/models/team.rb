class Team < ApplicationRecord
  has_many :players, dependent: :destroy

  validates_presence_of :name
end
