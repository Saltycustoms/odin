class ApiKey < ApplicationRecord
  class << self
    def apps
      [:deal, :design, :catalogue, :employee, :procurement]
    end
  end
end
