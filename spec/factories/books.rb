# spec/factories/books.rb

FactoryBot.define do
    factory :book do
      name { "The Great Gatsby" }
      author { "F. Scott Fitzgerald" }
      ISBN {978-3-16-148410-0}
      price { 9.99 }
      quantity_available {25}
    end
  end
  