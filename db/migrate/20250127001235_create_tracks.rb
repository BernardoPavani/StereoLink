class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :link
      t.references :album, null: false, foreign_key: true

      t.timestamps
    end
  end
end
