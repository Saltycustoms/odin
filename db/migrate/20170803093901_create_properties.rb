class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :value
      t.belongs_to :job_request, foreign_key: true

      t.timestamps
    end
  end
end
