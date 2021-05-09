FactoryBot.define do
  factory :user do
    nickname              { 'tanachi' }
    email                 { Faker::Internet.free_email }
    password              { 'test12' }
    password_confirmation { password }
    birth_date            { '2021-05-09' }
    last_name             { '田中' }
    first_name            { '太郎' }
    last_name_reading     { 'タナカ' }
    first_name_reading    { 'タロウ' }
  end
end
