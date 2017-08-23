class Property < ApplicationRecord
  acts_as_paranoid
  belongs_to :job_request
  validates :name, uniqueness: { scope: :job_request_id }

  def self.name_and_placeholders
    {"Relabeling": "What is relabeling?", "Woven tag": "Yes/No", "Hang tag": "Yes/No", "Sample required": "XS:2, S:1, M:1..."}
  end
end
