class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  validates :nickname,             presence: true
  validates :firstname,            presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :lastname,             presence: true, format: {with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :firstname_kana,       presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
  validates :lastname_kana,        presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
  validates :birthday,             presence: true
  validates :password,             presence: true, length: { minimum: 6 }
  validates :password,             presence: true, format: {with: /\A(?=.*[a-z])(?=.*?\d)[a-z\d]+\z/i }
end