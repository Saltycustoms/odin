class CreatePics < ActiveRecord::Migration[5.1]
  def change
    create_table :pics do |t|
      t.string :name
      t.string :tel
      t.string :title
      t.references :belongable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
