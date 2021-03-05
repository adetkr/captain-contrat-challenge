class Fight < ApplicationRecord
  has_many :players
  has_many :characters, through: :players

  accepts_nested_attributes_for :players
end
