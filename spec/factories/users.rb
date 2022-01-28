FactoryBot.define do
  factory :user do
    nickname { 'yamada' }
    firstname { '山田' }
    lastname { '太郎' }
    firstname_kana { 'ヤマダ' }
    lastname_kana { 'タロウ' }
    email { Faker::Internet.free_email }
    birthday { '1980-08-08' }
    password { 'a123456' }
    password_confirmation { password }
  end
end
