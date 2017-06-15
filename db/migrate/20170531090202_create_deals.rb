class CreateDeals < ActiveRecord::Migration[5.1]
  def change
    create_table :deals do |t|
      t.integer :department_id
      t.string :name
      t.integer :no_of_pcs

      t.timestamps
    end
  end
end
