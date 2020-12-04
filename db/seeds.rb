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

puts "Criando usuários..."
10.times do
  u = User.create(
    email: Faker::Internet.email,
    name: Faker::Name.name_with_middle,
    address: Faker::Address.street_address,
    birth_date: Faker::Date.birthday,
    telephone: Faker::PhoneNumber.phone_number,
    password: '123456'
  )
  puts "Usuário criado: #{u.id} | #{u.name} | #{u.address} | #{u.birth_date} | #{u.telephone}"
  u.save
end

puts "Criando produtos..."
50.times do
  p = Product.create(
    description: Faker::Commerce.product_name,
    category: ["Ternos", "Vestidos", "Acessórios"].sample,
    subcategory: ["Subcategoria 1", "Subcategoria 2", "Subcategoria 3"].sample,
    brand: ["Armani", "Lacoste", "Dolce & Gabanna"].sample,
    size: [rand(2..60), "PP", "P", "M", "G", "GG", "XG", "XXG", "Único"].sample,
    price: Faker::Commerce.price,
    user_id: rand(1..10)
  )
  puts "Produto #{p.id} - #{p.description} criado!"
  p.save
end

puts "Criando transações..."
100.times do
  t = Transaction.create(
    user_id: rand(1..10),
    product_id: rand(1..50),
    payment_method: ["Boleto", "Cartão de Crédito", "Transferência"].sample,
    price: rand(10..300)
  )
  puts "Transação criada: #{t.id} |Usuário: #{t.user_id}| Produto: #{t.product_id} | Forma de Pagamento: #{t.payment_method}"
  t.save
end
