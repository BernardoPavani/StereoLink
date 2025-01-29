class CreateAlbumGenres < ActiveRecord::Migration[7.1]
  def change
    create_table :album_genres do |t|
      t.references :album, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
