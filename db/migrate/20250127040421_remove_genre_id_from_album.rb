class RemoveGenreIdFromAlbum < ActiveRecord::Migration[7.1]
  def change
    remove_reference :albums, :genre, null: false, foreign_key: true
  end
end
