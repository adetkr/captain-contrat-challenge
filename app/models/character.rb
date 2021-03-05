class Character < ApplicationRecord
  validates :name , uniqueness: true, presence:true
  validates :life , presence: true
  validates :attack , presence: true
end
