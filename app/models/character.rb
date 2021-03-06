class Character < ApplicationRecord
  validates :name , uniqueness: true, presence:true
  validates :life , presence: true
  validates :attack , presence: true

  has_many :players
  has_many :fights, through: :players
  has_one_attached :photo
end
