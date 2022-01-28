require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '購入登録' do
    before do
      @purchase_address = FactoryBot.build(:purchase_address)
    end

    describe '購入登録' do
      context '登録できるとき' do
        it '必須項目が全てあれば登録できること' do
          expect(@purchase_address).to be_valid
        end

        it 'building_nameが空欄でも登録できること' do
          @purchase_address.building_name = ''
          expect(@purchase_address).to be_valid
        end
      end

      context '登録できないとき' do
        it 'postal_codeが空欄だと登録できないこと' do
          @purchase_address.postal_code = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank", 'Postal code is invalid')
        end

        it 'postal_codeにハイフンが含まれていないと登録できないこと' do
          @purchase_address.postal_code = 1_111_111
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('Postal code is invalid')
        end

        it 'prefecture_idが空欄だと登録できないこと' do
          @purchase_address.prefecture_id = ' '
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
        end

        it 'prefecture_idが1だと登録できないこと' do
          @purchase_address.prefecture_id = 1
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('Prefecture must be other than 1')
        end

        it 'cityが空欄だと登録できないこと' do
          @purchase_address.city = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("City can't be blank")
        end

        it 'house_numberが空欄だと登録できないこと' do
          @purchase_address.house_number = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("House number can't be blank")
        end

        it 'telが空欄だと登録できないこと' do
          @purchase_address.tel = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Tel can't be blank", 'Tel is invalid')
        end

        it 'telにハイフンがあると登録できないこと' do
          @purchase_address.tel = '000 - 0000 - 0000'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('Tel is invalid')
        end

        it 'telが12桁以上だと登録できないこと' do
          @purchase_address.tel = '000000000000'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('Tel is invalid')
        end

        it 'telが9桁以下だと登録できないこと' do
          @purchase_address.tel = '000000000'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include('Tel is invalid')
        end

        it 'tokenが空欄だと登録できないこと' do
          @purchase_address.token = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
        end

        it 'userが紐付いていなければ購入できないこと' do
          @purchase_address.user_id = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("User can't be blank")
        end

        it 'itemが紐付いていなければ購入できないこと' do
          @purchase_address.item_id = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
        end
      end
    end
  end
end
