FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) {|n| "foo#{n}@gmail.com" }
    password "foobar"
  end
end