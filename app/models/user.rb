class User < ApplicationRecord

  has_many :items
  has_many :orders
  has_many :comments
  has_many :sns_credentials
  has_one  :card, dependent: :destroy

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
        email: auth.info.email
    )

    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end

  devise :database_authenticatable, :registerable, 
  :recoverable, 
  :rememberable, 
  :validatable, 
  :omniauthable, 
  omniauth_providers: [:facebook, :google_oauth2]

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
