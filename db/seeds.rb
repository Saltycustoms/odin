# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

test_job_request = JobRequest.create(deal_id: 1, name: "test job request", sizes: 1, colors: 2, product_id: 1)
test_job_request.job_request_products.create(product_id: 1, sizes: "[\"\", \"1\", \"2\"]", colors: "[\"\", \"1\", \"2\"]")
test_job_request.job_request_products.create(product_id: 2, sizes: "[\"\", \"3\", \"4\"]", colors: "[\"\", \"3\", \"4\"]")
