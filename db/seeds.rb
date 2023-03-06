10.times do
  Book.create(
    name: Faker::Book.title,
    author: Faker::Book.author,
    price: rand(10.0...100.0).round(2),
    ISBN: Faker::Code.isbn,
    quantity_available: rand(0..10),
    created_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    updated_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  )
end
