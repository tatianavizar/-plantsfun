require "json"
require "open-uri"

Plant.destroy_all

puts "Starting seeding with API..."

url = "https://trefle.io/api/v1/plants?token=vtYf38EultVI70cgHGebZmKyJle51djAj52dzG00ew4"
response = URI.open(url).read # Utilise open-uri pour lire directement le contenu de l'URL
plants = JSON.parse(response)["data"]

plants.each do |plant|
  Plant.create(
    name: plant["common_name"],
    category: plant["family"],
    level: rand(1..3),
    inventory: rand(0..30),
    image: plant["image_url"],
    price: rand(1..10)
  )
end
puts "Seeding completed!"
