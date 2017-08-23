class AddDeletedAtToAttachments < ActiveRecord::Migration[5.1]
  def change
    add_column :attachments, :deleted_at, :datetime
    add_index :attachments, :deleted_at
  end
end
