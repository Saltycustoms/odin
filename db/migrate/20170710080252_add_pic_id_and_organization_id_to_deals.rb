class AddPicIdAndOrganizationIdToDeals < ActiveRecord::Migration[5.1]
  def change
    add_column :deals, :pic_id, :integer
    add_column :deals, :organization_id, :integer
  end
end
