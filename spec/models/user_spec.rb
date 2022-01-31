require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録ができるとき' do
        it "必須項目が全てあれば登録できること" do
          expect(@user).to be_valid
        end
        it 'パスワードが６文字以上の半角英数字であれば登録できること' do
          @user.password = 'a123456'
          @user.password_confirmation = 'a123456'
          expect(@user).to be_valid
        end
      end

      context '新規登録ができないとき' do
        it 'ニックネームが空欄だと登録できないこと' do
          @user.nickname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("ニックネームを入力してください")
        end

        it 'お名前(姓)が空欄だと登録できないこと' do
          @user.firstname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("お名前(姓)を入力してください")
        end

        it 'お名前(名)が空欄だと登録できないこと' do
          @user.lastname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("お名前(名)を入力してください")
        end

        it 'お名前カナ(名)が空欄だと登録できないこと' do
          @user.firstname_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("お名前カナ(名)を入力してください")
        end

        it 'お名前カナ(姓)が空欄だと登録できないこと' do
          @user.lastname_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("お名前カナ(姓)を入力してください")
        end

        it 'お名前(姓)が全角（漢字・ひらがな・カタカナ）以外だとユーザー登録できないこと' do
          @user.firstname = 'yamada'
          @user.valid?
          expect(@user.errors.full_messages).to include("お名前(姓)は不正な値です")
        end

        it 'お名前(名)が全角（漢字・ひらがな・カタカナ）以外だとユーザー登録できないこと' do
          @user.lastname = 'tarou'
          @user.valid?
          expect(@user.errors.full_messages).to include("お名前(名)は不正な値です")
        end

        it 'お名前カナ(名)が全角（カタカナ）以外だとユーザー登録できないこと' do
          @user.firstname_kana = '山田'
          @user.valid?
          expect(@user.errors.full_messages).to include("お名前カナ(名)は不正な値です")
        end

        it 'お名前カナ(姓)が全角（カタカナ）以外だとユーザー登録できないこと' do
          @user.lastname_kana = '太郎'
          @user.valid?
          expect(@user.errors.full_messages).to include("お名前カナ(姓)は不正な値です")
        end

        it '誕生日が空欄だと登録できないこと' do
          @user.birthday = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("誕生日を入力してください")
        end

        it 'パスワードが空欄だと登録できないこと' do
          @user.password = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードを入力してください")
        end

        it 'パスワードが5文字以下であれば登録できないこと' do
          @user.password = 'a1234'
          @user.password_confirmation = 'a1234'
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
        end

        it 'パスワードが半角英字のみだとユーザー登録できないこと' do
          @user.password = 'abcdef'
          @user.password_confirmation = 'abcdef'
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードは不正な値です")
        end

        it 'パスワードが半角数字のみだとユーザー登録できないこと' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードは不正な値です")
        end

        it 'パスワードが全角文字を含むと登録できないこと' do
          @user.password = 'Ａ123456'
          @user.password_confirmation = 'Ａ123456'
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードは不正な値です")
        end

        it 'パスワードとパスワード（確認用）が不一致では登録できないこと' do
          @user.password = 'a123456'
          @user.password_confirmation = 'b123456'
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
        end

        it 'Eメールが空欄だと登録できないこと' do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Eメールを入力してください")
        end

        it '重複したEメールが存在すると登録できないこと' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
        end

        it 'Eメールに@が含まれていないとユーザー登録できないこと' do
          @user.email = 'abcgmail.com'
          @user.valid?
          expect(@user.errors.full_messages).to include("Eメールは不正な値です")
        end
      end
    end
  end
end
