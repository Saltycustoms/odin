class AddProDesignBriefAndConceptToJobRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :job_requests, :design_brief, :text
    add_column :job_requests, :concept, :text
  end
end
