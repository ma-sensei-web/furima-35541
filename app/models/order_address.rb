class OrderAddress
  include ActiveModel::Model
  attr_accessor :token, :postal_code, :area_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id
  
  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "はハイフンが必要です。次のように入力してください（例：123-4567）" }
    validates :area_id, numericality: { other_than: 0, message: "を入力してください" }
    validates :city
    validates :house_number
    validates :phone_number, length: { minimum: 10, maximum: 11, message: "は最小10桁から最大11桁で入力してください" }
  end
  
  validates :phone_number, numericality: { with: /\A[0-9]+\z/, message: "は半角数字で入力してください" }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, area_id: area_id, city: city, house_number: house_number, building_name: building_name, phone_number: phone_number, order_id: order.id)
  end
end