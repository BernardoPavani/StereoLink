class Album < ApplicationRecord
  has_many :tracks, dependent: :destroy
  belongs_to :user
  has_many :album_genres, dependent: :destroy
  has_many :genres, through: :album_genres

  accepts_nested_attributes_for :genres

  validates :title, presence: true
  validates :description, presence: true
end
