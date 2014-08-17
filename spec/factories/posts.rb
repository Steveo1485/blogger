FactoryGirl.define do
  factory :post do
    title {Faker::Lorem.word.capitalize}
    content {Faker::Lorem.paragraph}
    active true
  end
end