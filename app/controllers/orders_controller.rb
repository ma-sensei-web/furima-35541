class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order
  before_action :move_to_index


  def index
    @order_address = OrderAddress.new
  end
  
  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
    # session["devise.regist_data"] = {user: @user.attributes}
    # session["devise.regist_data"][:user]["password"] = params[:user][:password]
    # @order_address = @user.build_order_address
    # render :new_order_address
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :area_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_order
    @item = Item.find(params[:item_id])
  end


  def move_to_index
    if @item.order.present? || current_user.id == @item.user_id
      redirect_to root_path
    end
  end
end
