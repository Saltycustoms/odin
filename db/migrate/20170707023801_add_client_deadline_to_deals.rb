class AddClientDeadlineToDeals < ActiveRecord::Migration[5.1]
  def change
    add_column :deals, :client_deadline, :date
  end
end
