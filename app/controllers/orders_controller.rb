class OrdersController < ApplicationController
  def index
    @items = Item.includes(:user).order("created_at DESC")
    # @orders_addresses = OrderAddress.includes(:item).order("created_at DESC")
  end
end
