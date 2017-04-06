class Design < ApplicationRecord
  belongs_to :blank
  belongs_to :orders
  has_many :order_lines

  sides = [:front,:back,:left,:right,:top,:bottom,:custom1,:custom2,:custom3]
  side_data_types = {}

  sides.each do |side|
    # include DesignUploader["#{side}_fg_image"]
    # include DesignUploader["#{side}_bg_image"]
    side_data= ["#{side}_fg_x", "#{side}_fg_y", "#{side}_fg_width", "#{side}_fg_height",
                "#{side}_fg_image_data", "#{side}_fg_text_data", "#{side}_fg_is_text",
                "#{side}_fg_text_font", "#{side}_fg_text_color", "#{side}_fg_attachment_id",
                "#{side}_bg_x", "#{side}_bg_y", "#{side}_bg_width", "#{side}_bg_height",
                "#{side}_bg_image_data", "#{side}_bg_attachment_id", "#{side}_preview", "#{side}_cut_piece"]

    side_data.each do |sd|
      side_data_types[sd] = :string
    end

    define_method "#{side}" do
      retval = {}
      side_data.each do |sd|
        retval[sd] = self.send sd
      end
      retval
    end
  end
  side_data_types["left_sleeve_cut_piece"] = :string
  side_data_types["right_sleeve_cut_piece"] = :string
  jsonb_accessor :properties, side_data_types

  # jsonb_accesor :properties,
  #   side: :string,
  #   x: :integer,
  #   y: :integer,
  #   top: :integer,
  #   left: :integer,
  #   image_data: :string

  def test_image_data
    {"id":"5a9508142eca7b1ec64b60e90fff6174.jpg","storage":"store","metadata":{"filename":"49116b9c6182532a97a7da997761bf67.jpg","size":285355,"mime_type":"image/jpeg"}}
  end

  def self.sides
    [:front,:back,:left,:right,:top,:bottom,:custom1,:custom2,:custom3]
  end
end
