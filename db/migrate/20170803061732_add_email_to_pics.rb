class AddEmailToPics < ActiveRecord::Migration[5.1]
  def change
    add_column :pics, :email, :string
  end
end
