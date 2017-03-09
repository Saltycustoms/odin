class CreateBlanks < ActiveRecord::Migration[5.0]
  def change
    create_table :blanks do |t|
      t.integer :price_cents, default: 0
      t.string :name
      t.jsonb :meta

      t.timestamps
    end
  end
end
