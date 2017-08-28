class RemoveRolesFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :roles, :integer
  end
end
