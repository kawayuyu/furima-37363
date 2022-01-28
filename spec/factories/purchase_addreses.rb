FactoryBot.define do
  factory :purchase_address do
    user_id { 1 }
    item_id { 1 }
    postal_code { '111-1111' }
    prefecture_id { 2 }
    city { '市町村' }
    house_number { '番地' }
    building_name { '建物名' }
    tel { '09012345678' }
    token { 'tok_sample' }
  end
end
