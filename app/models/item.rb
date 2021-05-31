class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_many_attached :images

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :charge
  belongs_to :area
  belongs_to :scheduled_delivery

  with_options presence: true do
    validates :images
    validates :name
    validates :explanation
  end

  validates :price, presence: true, numericality: { with: /\A[0-9]+\z/, message: 'は半角数字で入力してください' }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'の設定は¥300〜9,999,999です' }

  with_options numericality: { other_than: 0, message: "を入力してください" } do
    validates :category_id
    validates :status_id
    validates :charge_id
    validates :area_id
    validates :scheduled_delivery_id
  end
end
