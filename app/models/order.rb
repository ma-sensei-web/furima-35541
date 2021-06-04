class Order < ApplicationRecord
  # belongs_to :user
  belongs_to :user, optional: true
  belongs_to :item
  has_one :address
end
