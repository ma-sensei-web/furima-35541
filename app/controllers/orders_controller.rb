class OrdersController < ApplicationController
  def index
    @orders_addresses = OrderAddress.includes(:item).order("created_at DESC")
  end
  
end
