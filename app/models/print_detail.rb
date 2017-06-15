class PrintDetail < ApplicationRecord
  belongs_to :job_request
  
  def self.print_methods
    ['Silkscreen',
      'Heat Transfer',
      'Crackle',
      'Crystalina (Glitter)',
      'Foil',
      'Flocking',
      'Gel',
      'Glow-In-The-Dark',
      'High Density',
      'High Gloss',
      'Metallic',
      'Pearlescent',
      'Puff',
      'Embroidery',
      'Dye Sub',
      'Full Embroidery',
      'CMYK']
  end

  def self.block_sizes
    ['A3','A3+','A4','A5','Full','N/A','3 x 3']
  end

  def self.print_positions
    ['Front','Back','Side Left','Side Right']
  end
end
