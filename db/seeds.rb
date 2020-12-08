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
n = 1
puts "Criando usuários..."
10.times do
  rua = address.sample['properties']['street']
  numero = address.sample['properties']['number']
  u = User.create!(
    email: Faker::Internet.email,
    name: Faker::Name.name_with_middle,
    address: "#{rua}, #{numero}",
    birth_date: 19900101,
    telephone: Faker::PhoneNumber.phone_number,
    password: '123456')
    u.photo.attach(io: File.open("app/assets/images/#{n}.jpeg"), filename: "#{n}.jpeg", content_type: 'image/jpeg')
  puts "Usuário criado: #{u.id} | #{u.name} | #{u.address} | #{u.birth_date} | #{u.telephone}"
  u.save
  n += 1
end

product_collection = [{desc: "Vestido para festa branco com pequenos detalhes em pretos. Sem marcas de usos. Acompanha cinto escuro.", cat: "Vestido", subcat: "Vestido de Festa", bra: "Gucci", si: "G"},
                      {desc: "Sapato masculino confeccionado com couro italiano sem marcas de uso", cat: "Sapato Masculino", subcat: "Sapato social", bra: "Gucci", si: "42"},
                      {desc: "Terno italiano com três botões e detalhes no punho. Completamente novo.", cat: "Terno", subcat: "Black Tie", bra: "Louis Vuitton", si: "M"},
                      {desc: "Terno com dois botões, cinza com pouco uso. Acompanha gravata borboleta", cat: "Terno", subcat: "Black Tie", bra: "Cartier", si: "G"},
                      {desc: "Vestido de noiva com transparência frontal e detalhes em prata. Pouco usado.", cat: "Vestido", subcat: "Vestido de Casamento", bra: "Channel", si: "P"},
                      {desc: "Vestido de noiva com decote e detalhes em madrepérola. Novo.", cat: "Vestido", subcat: "Vestido de Casamento", bra: "Gucci", si: "M"},
                      {desc: "Sapato de festa branco com detalhes prateados na parte de trás. Lindo", cat: "Sapato Feminino", subcat: "Salto Alto", bra: "Prada", si: "37"},
                      {desc: "Sapato de salto alto maravilhoso dourado.", cat: "Sapato Feminino", subcat: "Salto Alto", bra: "Louis Vuitton", si: "35"}]

i = 1
puts "Creating products..."
product_collection.each do |prod|

  p = Product.create!(
      description: prod[:desc],
      category: prod[:cat],
      subcategory: prod[:subcat],
      brand: prod[:bra],
      size: prod[:si],
      price: Faker::Commerce.price(range: 50..400.0),
      user_id: rand(1..10)
      )
    # description: Faker::Commerce.product_name,
    # category: ["Vestido", "Acessório", "Sapato Feminino", "Terno", "Acessório Masculino", "Sapato Masculino"].sample,
    # subcategory: ["Camisa Social", "Blazer", "Calça Social", "Terninho", "Saia Midi", "Vesido Social", "Vestido de Festa", "Salto Alto", "Bijuterias", "Esporte Fino", "Black Tie", "Terno com colete", "Gravata", "Cinto" ].sample,
    # brand: ["Louis Vuitton", "Lanvin", "Prada", "Cartier", "Channel", "Gucci"].sample,

    # size: [rand(2..60), "PP", "P", "M", "G", "GG", "XG", "XXG", "Único"].sample,


    fotos = ["#{i}_1", "#{i}_2", "#{i}_3"]
    fotos.each do |foto|
      p.photos.attach(io: File.open("app/assets/images/#{foto}.jpeg"), filename: "#{foto}.jpeg", content_type: 'image/jpeg')
    end
    i += 1



  p.save
  puts "Product #{p.id} - #{p.description} created!"
end

puts "Criando transações..."
20.times do
  t = Transaction.create(
    user_id: rand(1..10),
    product_id: rand(1..50),
    payment_method: ["Boleto", "Cartão de Crédito", "Transferência"].sample,
    price: rand(50..400)
  )
  puts "Transação criada: #{t.id} |Usuário: #{t.user_id}| Produto: #{t.product_id} | Forma de Pagamento: #{t.payment_method}"
  t.save
end
