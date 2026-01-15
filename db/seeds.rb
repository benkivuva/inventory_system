# db/seeds.rb

puts "Seeding database..."

Product.destroy_all

products = [
  { name: "Laptop Pro X1", description: "High-performance laptop for developers", price: 1299.99, quantity: 50, low_stock_threshold: 5 },
  { name: "Wireless Mouse", description: "Ergonomic bluetooth mouse", price: 49.99, quantity: 150, low_stock_threshold: 20 },
  { name: "4K Monitor 27\"", description: "IPS display with 144Hz refresh rate", price: 349.50, quantity: 8, low_stock_threshold: 10 },
  { name: "Mechanical Keyboard", description: "RGB backlit with cherry MX switches", price: 120.00, quantity: 0, low_stock_threshold: 15 },
  { name: "USB-C Hub", description: "7-in-1 adapter", price: 29.99, quantity: 200, low_stock_threshold: 30 }
]

products.each do |p|
  Product.create!(p)
  puts "Created #{p[:name]}"
end

puts "Done! Created #{Product.count} products."
