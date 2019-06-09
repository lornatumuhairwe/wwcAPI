class Player < ApplicationRecord
  belongs_to :team

  validates_presence_of :team, :name
end
