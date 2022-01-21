FactoryBot.define do
  factory :item do
    name { '山田' }
    price { '300' }
    detail { '綺麗' }
    category_id { 3 }
    status_id { 3 }
    delivery_fee_id { 3 }
    prefecture_id { 3 }
    scheduled_delivery_id { 3 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
