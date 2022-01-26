class PurchaseAddress

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :tel, :user_id


  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :prefecture_id
    validates :city
    validates :house_number
    validates :tel, numericality: { less_than_or_equal_to: 11 }
end

  with_options numericality: { other_than: 1 } do
    validates :prefecture_id
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(prefecture_id: prefecture_id, postal_code: postal_code, city: city, house_number: house_number, building_name: building_name, tel: tel, purchase_id: purchase.id)
  end

end