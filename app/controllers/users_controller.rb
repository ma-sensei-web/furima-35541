class UsersController < ApplicationController
  # before_action :set_user, only: [:update]
  # before_action :move_to_index, only: [:show]

  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)

    redirect_to new_card_path and return unless card.present?
    # redirect_to new_card_path and return if card.present?

    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
  end

  # def update
  #   if current_user.update(user_params)
  #     redirect_to root_path
  #   else
  #     # redirect_to action: "show"
  #     render :show
  #   end
  # end

  private

  def user_params
    params.require(:user).permit(:nickname, :email)
    # .merge(user_id: current_user.id)
  end

  # def set_user
  #   @user = User.find(params[:id])
  # end

  # def move_to_index
  #   if current_user.id != @comment.user_id
  #     redirect_to root_path
  #   end
  # end
end
