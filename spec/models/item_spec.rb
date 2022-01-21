require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '出品登録' do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '出品登録' do
      context '出品ができるとき' do
        it '必須項目が全てあれば出品できること' do
          expect(@item).to be_valid
        end
        it 'ログイン状態のユーザーのみ、商品出品ページへ遷移できること' do
          @item = FactoryBot.create(:user)
          expect(@item).to be_valid
        end
      end

      context '出品ができないとき' do
        it 'userが紐付いていなければ出品できないこと' do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('User must exist')
        end

        it 'imageが空欄だと出品できないこと' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end

        it 'nameが空欄だと出品できないこと' do
          @item.name = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end

        it 'priceが空欄だと出品できないこと' do
          @item.price = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end

        it 'detailが空欄だと出品できないこと' do
          @item.detail = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Detail can't be blank")
        end

        it 'category_idが空欄だと出品できないこと' do
          @item.category_id = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('Category is not a number', "Category can't be blank")
        end

        it 'status_idが空欄だと出品できないこと' do
          @item.status_id = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('Status is not a number', "Status can't be blank")
        end

        it 'delivery_fee_idが空欄だと出品できないこと' do
          @item.delivery_fee_id = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('Delivery fee is not a number', "Delivery fee can't be blank")
        end

        it 'prefecture_idが空欄だと出品できないこと' do
          @item.prefecture_id = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture can't be blank")
        end

        it 'scheduled_delivery_idが空欄だと出品できないこと' do
          @item.scheduled_delivery_id = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank", 'Scheduled delivery is not a number')
        end

        it 'priceが¥300以下だと出品できないこと' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
        end

        it 'priceが¥9999999以上だと出品できないこと' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
        end

        it 'priceが全角数字だと出品できないこと' do
          @item.price = '１１１１'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is not a number')
        end

        it 'category_idが1だと出品できないこと' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Category must be other than 1')
        end

        it 'status_idが1だと出品できないこと' do
          @item.status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Status must be other than 1')
        end

        it 'delivery_fee_idが1だと出品できないこと' do
          @item.delivery_fee_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Delivery fee must be other than 1')
        end

        it 'prefecture_idが1だと出品できないこと' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
        end

        it 'scheduled_delivery_idが1だと出品できないこと' do
          @item.scheduled_delivery_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('Scheduled delivery must be other than 1')
        end
      end
    end
  end
end
