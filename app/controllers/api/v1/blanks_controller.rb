class Api::V1::BlanksController < ApiController
  def index
    @blanks = Blank.all.includes(:surfaces)
  end
end
