FactoryGirl.define do
  factory :post do
    title "Welcome!"
    content { Faker::Lorem.paragraph }
  end
end