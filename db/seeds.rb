# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Apagando dados anteriores..."
Product.destroy_all
User.destroy_all
Transaction.destroy_all
puts "Dados apagados!"


puts "Creating users..."

10.times do
  u = User.create(
    email: Faker::Internet.email,
    name: Faker::Name.name_with_middle,
    address: Faker::Address.street_address,
    birth_date: Faker::Date.birthday,
    telephone: Faker::PhoneNumber.phone_number,
    password: '123456'
  )
  puts "User created: #{u.id} | #{u.name} | #{u.address} | #{u.birth_date} | #{u.telephone}"
  u.save
end

puts "Creating products..."

50.times do
  p = Product.create(
    description: Faker::Commerce.product_name,
    category: ["Categoria 1", "Categoria 2", "Categoria 3"].sample,
    subcategory: ["Subcategoria 1", "Subcategoria 2", "Subcategoria 3"].sample,
    brand: ["Marca 1", "Marca 2", "Marca 3"].sample,
    size: [rand(2..60), "PP", "P", "M", "G", "GG", "XG", "XXG", "Único"].sample,
    price: Faker::Commerce.price,
    user_id: rand(1..10)
  )
  puts "Product #{p.id} - #{p.description} created!"
  p.save
end

# puts "Apagando transações anteriores..."
# Transaction.destroy_all
# puts "Transações apagadas!"
puts "Creating transactions..."

100.times do
  t = Transaction.create(
    user_id: rand(1..10),
    product_id: rand(101..150),
    payment_method: ["Boleto", "Cartão de Crédito", "Transferência"].sample
  )
  puts "Transaction created: #{t.id} |User: #{t.user_id}| Product: #{t.product_id} | Payment method: #{t.payment_method}"
  t.save
end
