class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    if table_exists?(:artists)
      drop_table :artists
    end

    create_table :artists do |t|

      # CUSTOM ATTRIBUTES
      t.string :name

      t.timestamps null: false
    end

    add_index :artists, :id,   unique: true
    add_index :artists, :name, unique: true
  end
end
