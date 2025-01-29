class Genre < ApplicationRecord
  has_many :album_genres, dependent: :destroy
  has_many :albums, through: :album_genres

  validates :name, presence: true
end
