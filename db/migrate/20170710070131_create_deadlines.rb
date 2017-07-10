class CreateDeadlines < ActiveRecord::Migration[5.1]
  def change
    create_table :deadlines do |t|
      t.belongs_to :deal, foreign_key: true
      t.date :deadline
      t.text :reason
      t.string :cause_by

      t.timestamps
    end
  end
end
