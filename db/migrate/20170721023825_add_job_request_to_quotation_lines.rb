class AddJobRequestToQuotationLines < ActiveRecord::Migration[5.1]
  def change
    add_reference :quotation_lines, :job_request, foreign_key: true
  end
end
