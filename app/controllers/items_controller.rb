class ItemsController < ApplicationController

  def index
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if user
        items = user.items
      else 
        render json: {error: "user not found"}, status: :not_found
        return
      end
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    user = User.find_by(id: params[:user_id])
    item = user.items.find_by(id: params[:id])
    if item
      render json: item, include: :user
    else 
      render json: {error: "no item was found"}, status: :not_found
    end
  end

  def create
    user = User.find_by(id: params[:user_id])
    new_item = user.items.create(item_params)
    render json: new_item, inlcude: :user, status: :created
    # byebug
  end

  private

  def item_params
    params.permit(:name, :description, :price)
  end

end
