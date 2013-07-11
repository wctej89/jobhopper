# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    name "awesome ruby job"
    description "this is an awesome ruby job"
    email "foo@bar.com"
    company "Bonobos"
    source_url "http://www.bonobos.com"
    lat "37.1112"
    lng "122.1112"
  end
end
