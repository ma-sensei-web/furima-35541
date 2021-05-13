class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :city, :house_number, :building_name, :tel, :user_id, :item_id

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
    validates :city
    validates :house_number
    validates :area_id, numericality: { other_than: 0 }
    validates :tel, length: { minimum: 6, message: "is too short" }
  end
  
  validates :tel, numericality: { with: /\A[0-9]+\z/, message: "is invalid. Input only number" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, area_id: area_id, city: city, house_number: house_number, building_name: building_name, tel: tel, order_id: order.id)
  end
end