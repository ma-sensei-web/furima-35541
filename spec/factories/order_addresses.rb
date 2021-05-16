FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    area_id { 1 }
    city { '東京都' }
    house_number { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { Faker::PhoneNumber.subscriber_number(length: 11) }

    association :item

    
  end
end
