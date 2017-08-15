class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.belongs_to :job_request, foreign_key: true
      t.text :attachment_data

      t.timestamps
    end
  end
end
