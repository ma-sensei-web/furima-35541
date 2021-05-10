class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]


  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  private
  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :status_id, :charge_id, :area_id, :day_id, :price, :image).merge(user_id: current_user.id)
  end
end
