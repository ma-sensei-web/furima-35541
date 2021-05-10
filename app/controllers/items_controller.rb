class ItemsController < ApplicationController
  def index
  end

  private
  def prototype_params
    params.require(:item).permit(:name, :explanation, :category_id, :status_id, :charge_id, :area_id, :day_id, :price, :image).merge(user_id: current_user.id)
  end
end
