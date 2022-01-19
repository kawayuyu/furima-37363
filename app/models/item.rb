class Item < ApplicationRecord
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :scheduled_delivery_id

  with_options presence: true do
    validates :name
    validates :price
    validates :detail
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :steatus_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

end
