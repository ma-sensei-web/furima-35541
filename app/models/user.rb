class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: {with: /\A[a-z0-9]+\z/i, message: "Include both letters and numbers"}
  validates :nickname, presence: true
  validates :birth_date, presence: true

  with_options presence: true do
    validates :last_name, :first_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "Full-width characters"}
    validates :last_name_reading, :first_name_reading, format: {with: /\A[ァ-ヶー]+\z/, message: "Full-width katakana characters"}
  end

end
