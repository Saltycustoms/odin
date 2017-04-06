class AddSafePrintAreaWidthAndHeightInMmToSurface < ActiveRecord::Migration[5.0]
  def change
    add_column :surfaces, :safe_print_area_width_mm, :integer
    add_column :surfaces, :safe_print_area_height_mm, :integer
  end
end
