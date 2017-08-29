class HistoriesController < ApplicationController
  def index
    @item_types = PaperTrail::Version.select(:item_type).distinct.pluck(:item_type)
    @items = {}
    @item_types.each do |item_type|
      @items[item_type] = PaperTrail::Version.where(item_type: item_type)
    end
  end
end
