class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :show, :update, :destroy, :order]
  before_action :search_item, only: [:index, :search]
  before_action :move_to_index, except: [:index, :show, :new, :create, :search]

  def index
    @items = Item.includes(:user).order('created_at DESC')
    set_item_column
    # set_category_column
  end

  def order
    redirect_to new_card_path and return unless current_user.card.present?

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @item.price,
      customer: customer_token,
      currency: 'jpy'
    )
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def edit
  end
  
  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def search
    @results = @p.result.includes(:name)
  end

  private

  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :status_id, :charge_id, :area_id, :scheduled_delivery_id, :price, images: []).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def search_item
    @p = Item.ransack(params[:q])
  end

  def set_item_column
    @item_name = Item.select("name").distinct
  end

  # def set_category_column
  #   @category_name = Category.select("name").distinct
  # end

  def move_to_index
    if @item.order.present? || current_user.id != @item.user_id
      redirect_to root_path
    end
  end
end
