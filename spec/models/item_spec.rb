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
        it 'Userが紐付いていなければ出品できないこと' do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Userを入力してください")
        end

        it '商品画像が空欄だと出品できないこと' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("商品画像を入力してください")
        end

        it '商品名が空欄だと出品できないこと' do
          @item.name = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("商品名を入力してください")
        end

        it '販売価格が空欄だと出品できないこと' do
          @item.price = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格を入力してください")
        end

        it '商品の説明が空欄だと出品できないこと' do
          @item.detail = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("商品の説明を入力してください")
        end

        it 'カテゴリーが空欄だと出品できないこと' do
          @item.category_id = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
        end

        it '商品の状態が空欄だと出品できないこと' do
          @item.status_id = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("商品の状態を入力してください")
        end

        it '配送料が空欄だと出品できないこと' do
          @item.delivery_fee_id = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("配送料を入力してください")
        end

        it '発送元の地域が空欄だと出品できないこと' do
          @item.prefecture_id = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
        end

        it '発送までの日数が空欄だと出品できないこと' do
          @item.scheduled_delivery_id = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
        end

        it '販売価格が¥300以下だと出品できないこと' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格は300以上の値にしてください")
        end

        it '販売価格が¥9999999以上だと出品できないこと' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格は9999999以下の値にしてください")
        end

        it '販売価格が全角数字だと出品できないこと' do
          @item.price = '１１１１'
          @item.valid?
          expect(@item.errors.full_messages).to include("販売価格は数値で入力してください")
        end

        it 'カテゴリーが1だと出品できないこと' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("カテゴリーは1以外の値にしてください")
        end

        it '商品の状態が1だと出品できないこと' do
          @item.status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("商品の状態は1以外の値にしてください")
        end

        it '配送料が1だと出品できないこと' do
          @item.delivery_fee_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("配送料は1以外の値にしてください")
        end

        it '発送元の地域が1だと出品できないこと' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("発送元の地域は1以外の値にしてください")
        end

        it '発送までの日数が1だと出品できないこと' do
          @item.scheduled_delivery_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("発送までの日数は1以外の値にしてください")
        end
      end
    end
  end
end
