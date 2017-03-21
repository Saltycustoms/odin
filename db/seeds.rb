# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def get_fixture_file(file)
  File.open(Rails.root.join("test/fixtures/files", file))
end

unisex_blank_front_image = get_fixture_file('UnisexRN_front.png')
unisex_blank_back_image  = get_fixture_file('UnisexRN_back.png')
@blank = Blank.find_or_create_by(price_cents: 2000, name: 'Foursquare Unisex Tee')
# find or create by is not working for shrine
@front = @blank.surfaces.find_or_initialize_by(side: "front", width: 300, height: 600, width_mm: 200, height_mm: 400, left: 20, top: 40)
@back  = @blank.surfaces.find_or_initialize_by(side: "back", width: 300, height: 600, width_mm: 200, height_mm: 400, left: 20, top: 30)
@front.image = unisex_blank_front_image
@front.save
@back.image = unisex_blank_back_image
@back.save

puts "Blank and surfaces created"

Address.find_or_create_by(
  att: "Larry Mckuydee",
  line1: 'A513 & 515 Kelana Square, Jalan SS7/26',
  line2: '',
  state: 'Selangor',
  country_code: 'MY',
  city: 'Kelana Jaya',
  post_code: '63000',
  tel: '0174815735'
)

Address.find_or_create_by(
  att: "Sean Yeoh",
  line1: 'A513 & 515 Kelana Square, Jalan SS7/26',
  line2: '',
  state: 'Selangor',
  country_code: 'MY',
  city: 'Kelana Jaya',
  post_code: '63000',
  tel: '012345678'
)

Address.find_or_create_by(
  att: "Calvin Tee",
  line1: 'A513 & 515 Kelana Square, Jalan SS7/26',
  line2: '',
  state: 'Selangor',
  country_code: 'MY',
  city: 'Kelana Jaya',
  post_code: '63000',
  tel: '0123456789'
)

Address.find_or_create_by(
  att: "Ezekiel",
  line1: 'A513 & 515 Kelana Square, Jalan SS7/26',
  line2: '',
  state: 'Selangor',
  country_code: 'MY',
  city: 'Kelana Jaya',
  post_code: '63000',
  tel: '0123456789'
)

puts "Addresses created"

(1..10).each do |i|
  Order.create(
    shipping_address_id: Address.all[i % Address.count].id,
    billing_address_id: Address.all[i % Address.count].id
  )
end

puts "Orders created"
