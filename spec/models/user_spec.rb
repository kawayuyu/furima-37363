require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context '新規登録ができるとき' do
        it "nickname,firstname,lastname,firstname_kana,lastname_kana,
        birthday,email,password,password_confirmationが存在すれば登録できること" do
          expect(@user).to be_valid
        end
        it 'passwordが６文字以上の半角英数字であれば登録できること' do
          @user.password = 'a123456'
          @user.password_confirmation = 'a123456'
          expect(@user).to be_valid
        end
      end

      context '新規登録ができないとき' do
        it 'nicknameが空欄だと登録できないこと' do
          @user.nickname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end

        it 'firstnameが空では登録できないこと' do
          @user.firstname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Firstname can't be blank")
        end

        it 'lastnameが空欄だと登録できないこと' do
          @user.lastname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Lastname can't be blank")
        end

        it 'firstname_kanaが空欄だと登録できないこと' do
          @user.firstname_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Firstname kana can't be blank")
        end

        it 'lastname_kanaが空欄だと登録できないこと' do
          @user.lastname_kana = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Lastname kana can't be blank")
        end

        it 'firstnameが全角（漢字・ひらがな・カタカナ）以外だとユーザー登録できないこと' do
          @user.firstname = 'yamada'
          @user.valid?
          expect(@user.errors.full_messages).to include('Firstname is invalid')
        end

        it 'lastnameが全角（漢字・ひらがな・カタカナ）以外だとユーザー登録できないこと' do
          @user.lastname = 'tarou'
          @user.valid?
          expect(@user.errors.full_messages).to include('Lastname is invalid')
        end

        it 'firstname_kanaが全角（カタカナ）以外だとユーザー登録できないこと' do
          @user.firstname_kana = '山田'
          @user.valid?
          expect(@user.errors.full_messages).to include('Firstname kana is invalid')
        end

        it 'lastname_kanaが全角（カタカナ）以外だとユーザー登録できないこと' do
          @user.lastname_kana = '太郎'
          @user.valid?
          expect(@user.errors.full_messages).to include('Lastname kana is invalid')
        end

        it 'birthdayが空欄だと登録できないこと' do
          @user.birthday = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end

        it 'passwordが空欄だと登録できないこと' do
          @user.password = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end

        it 'passwordが5文字以下であれば登録できないこと' do
          @user.password = 'a1234'
          @user.password_confirmation = 'a1234'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end

        it 'passwordが半角英字のみだとユーザー登録できないこと' do
          @user.password = 'abcdef'
          @user.password_confirmation = 'abcdef'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end

        it 'passwordが半角数字のみだとユーザー登録できない' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is invalid')
        end

        it 'passwordとpassword_confirmationが不一致では登録できないこと' do
          @user.password = 'a123456'
          @user.password_confirmation = 'b123456'
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end

        it 'emailが空欄だと登録できないこと' do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end

        it '重複したemailが存在すると登録できないこと' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end

        it 'emailに@が含まれていないとユーザー登録できないこと' do
          @user.email = 'abcgmail.com'
          @user.valid?
          expect(@user.errors.full_messages).to include('Email is invalid')
        end
      end
    end
  end
end
