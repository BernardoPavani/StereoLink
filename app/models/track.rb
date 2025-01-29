class Track < ApplicationRecord
  belongs_to :album
  
  validates :name, presence: true
  validates :link, presence: true
end
