class CreateSurfaces < ActiveRecord::Migration[5.0]
  def change
    create_table :surfaces do |t|
      t.text :image_data
      t.integer :blank_id
      t.integer :side
      t.integer :width
      t.integer :height
      t.integer :width_mm
      t.integer :height_mm
      t.integer :left
      t.integer :top

      t.timestamps
    end
  end
end
