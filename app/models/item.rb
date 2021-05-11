class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :charge
  belongs_to :area
  belongs_to :scheduled_delivery

  with_options presence: true do
    validates :image
    validates :name
    validates :explanation
  end

  validates :price, presence: true, numericality: { with: /\A[0-9]+\z/, message: 'is invalid. Input half-width characters' }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }

  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :category_id
    validates :status_id
    validates :charge_id
    validates :area_id
    validates :scheduled_delivery_id
  end
end
