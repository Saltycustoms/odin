class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description
      t.string :industry

      t.timestamps
    end
  end
end
