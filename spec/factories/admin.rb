# spec/factories/admins.rb
FactoryBot.define do
    factory :admin do
      name { Faker::Name.name }
      email { Faker::Internet.email }
      password { Faker::Internet.password(min_length: 6) }
    end
  end
  