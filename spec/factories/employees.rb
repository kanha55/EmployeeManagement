FactoryBot.define do
  factory :employee do
    employee_id { Faker::Number.unique.number(digits: 4) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    doj { Faker::Date.between(from: '2010-01-01', to: '2020-12-31') }
    salary { Faker::Number.decimal(l_digits: 2) }
    phone_numbers { [Faker::PhoneNumber.phone_number] }
  end
end