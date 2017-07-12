class RemoveJobRequestIdFromQuotations < ActiveRecord::Migration[5.1]
  def change
    remove_reference :quotations, :job_request, foreign_key: true
  end
end
