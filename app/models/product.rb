class Product < ActiveResource::Base
  self.site = "http://localhost:3002/api/v1/"
  class << self
    def all
      [
        {
          id: 1,
          name: "Gildan T",
          colors: colors.drop(1),
          sizes: sizes.drop(2),
          sides: sides
        },
        {
          id: 2,
          name: "Polo T",
          colors: colors.drop(2),
          sizes: sizes.drop(1),
          sides: sides
        },
        {
          id: 3,
          name: "Adult Unisex",
          colors: colors.drop(3),
          sizes: sizes.drop(3),
          sides: sides
        },
      ]
    end

    private

    def colors
      [
        {id: 1, name: "Red", hex: "#ff000"},
        {id: 2, name: "Green", hex: "#00ff00"},
        {id: 3, name: "Blue", hex: "#0000ff"},
        {id: 4, name: "Black", hex: "#000000"},
        {id: 5, name: "White", hex: "#ffffff"},
      ]
    end

    def sizes
      [
        {id: 1, name: "XS"},
        {id: 2, name: "S"},
        {id: 3, name: "M"},
        {id: 4, name: "L"},
        {id: 5, name: "XL"},
        {id: 6, name: "2XL"},
      ]
    end

    def sides
      [
        {id: 1, name: "Front", image_file: nil},
        {id: 2, name: "Back", image_file: nil}
      ]
    end
  end

end
