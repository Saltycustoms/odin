class AddEmployeeIdToDeal < ActiveRecord::Migration[5.1]
  def change
    add_column :deals, :employee_id, :integer
  end
end
