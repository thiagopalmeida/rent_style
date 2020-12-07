# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'json'
address = []
File.foreach('./db/address.json') do |line|
  address << JSON.parse(line.gsub('=>', ':'))
end

puts "Apagando dados anteriores..."
Product.destroy_all
User.destroy_all
Transaction.destroy_all
puts "Dados apagados!"

puts "Criando usuários..."
10.times do
  rua = address.sample['properties']['street']
  numero = address.sample['properties']['number']
  u = User.create(
    email: Faker::Internet.email,
    name: Faker::Name.name_with_middle,
    address: "#{rua}, #{numero}",
    birth_date: Faker::Date.birthday,
    telephone: Faker::PhoneNumber.phone_number,
    password: '123456'
  )
  puts "Usuário criado: #{u.id} | #{u.name} | #{u.address} | #{u.birth_date} | #{u.telephone}"
  u.save
end


puts "Creating products..."
15.times do
  p = Product.create!(
    description: Faker::Commerce.product_name,
    category: ["Vestido", "Acessório", "Sapato Feminino", "Terno", "Acessório Masculino", "Sapato Masculino"].sample,
    subcategory: ["Camisa Social", "Blazer", "Calça Social", "Terninho", "Saia Midi", "Vesido Social", "Vestido de Festa", "Salto Alto", "Bijuterias", "Esporte Fino", "Black Tie", "Terno com colete", "Gravata", "Cinto" ].sample,
    brand: [" Louis Vuitton", "Lanvin", "Prada", "Cartier", "Channel", "Gucci", "Dona Maria", "Feita em Casa", "DasLu", "DasPu"].sample,

    size: [rand(2..60), "PP", "P", "M", "G", "GG", "XG", "XXG", "Único"].sample,
    price: Faker::Commerce.price,
    user_id: rand(1..10)
  )

  3.times do
    file = URI.open('https://picsum.photos/250/150')
    p.photos.attach(io: file, filename: 'https://picsum.photos/250/150', content_type: 'image/png')
  end
  puts "Product #{p.id} - #{p.description} created!"

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
