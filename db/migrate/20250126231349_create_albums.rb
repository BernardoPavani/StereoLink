class CreateAlbums < ActiveRecord::Migration[7.1]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :description
      t.references :genre, null: false, foreign_key: true

      t.timestamps
    end
  end
end
