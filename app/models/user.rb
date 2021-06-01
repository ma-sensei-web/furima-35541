class User < ApplicationRecord


  has_many :items
  has_many :orders
  has_many :comments
  has_one :card, dependent: :destroy

  devise :database_authenticatable, :registerable, 
  :recoverable, 
  :rememberable, 
  :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'は文字と数字の両方を含めてください'

  with_options presence: true do
    validates :nickname
    validates :birth_date
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'を全角で入力してください' } do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: 'を全角カナで入力してください' } do
    validates :last_name_reading
    validates :first_name_reading
  end
end
