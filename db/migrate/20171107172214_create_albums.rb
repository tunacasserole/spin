class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    if table_exists?(:albums)
      drop_table :albums
    end

    create_table :albums do |t|

      # CUSTOM ATTRIBUTES
      t.string :name
      t.integer :artist_id
      t.string :year
      t.string :condition
      t.boolean :is_favorite

      t.timestamps null: false
    end

    add_index :albums, :id,   unique: true
    add_index :albums, :name, unique: true
  end
end
