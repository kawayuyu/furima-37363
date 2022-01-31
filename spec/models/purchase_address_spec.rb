require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  describe '購入登録' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
      sleep(1)
    end

    describe '購入登録' do
      context '登録できるとき' do
        it '必須項目が全てあれば登録できること' do
          expect(@purchase_address).to be_valid
        end

        it '建物名が空欄でも登録できること' do
          @purchase_address.building_name = ''
          expect(@purchase_address).to be_valid
        end
      end

      context '登録できないとき' do
        it '郵便番号が空欄だと登録できないこと' do
          @purchase_address.postal_code = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("郵便番号を入力してください")
        end

        it '郵便番号にハイフンが含まれていないと登録できないこと' do
          @purchase_address.postal_code = 1_111_111
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("郵便番号は不正な値です")
        end

        it '都道府県が空欄だと登録できないこと' do
          @purchase_address.prefecture_id = ' '
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("都道府県を入力してください")
        end

        it '都道府県が1だと登録できないこと' do
          @purchase_address.prefecture_id = 1
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("都道府県は1以外の値にしてください")
        end

        it '市区町村が空欄だと登録できないこと' do
          @purchase_address.city = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("市区町村を入力してください")
        end

        it 'house_numberが空欄だと登録できないこと' do
          @purchase_address.house_number = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("番地を入力してください")
        end

        it '電話番号が空欄だと登録できないこと' do
          @purchase_address.tel = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("電話番号を入力してください")
        end

        it '電話番号にハイフンがあると登録できないこと' do
          @purchase_address.tel = '000 - 0000 - 0000'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("電話番号は不正な値です")
        end

        it '電話番号が12桁以上だと登録できないこと' do
          @purchase_address.tel = '000000000000'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("電話番号は不正な値です")
        end

        it '電話番号が9桁以下だと登録できないこと' do
          @purchase_address.tel = '000000000'
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("電話番号は不正な値です")
        end

        it 'カード情報が空欄だと登録できないこと' do
          @purchase_address.token = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("カード情報を入力してください")
        end

        it 'Userが紐付いていなければ購入できないこと' do
          @purchase_address.user_id = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("cを入力してください")
        end

        it 'Itemが紐付いていなければ購入できないこと' do
          @purchase_address.item_id = nil
          @purchase_address.valid?
          expect(@purchase_address.errors.full_messages).to include("Itemを入力してください")
        end
      end
    end
  end
end
