class AddUploadAttachmentToPackingLists < ActiveRecord::Migration[5.1]
  def change
    add_column :packing_lists, :upload_attachment, :boolean, default: false
  end
end
