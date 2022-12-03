class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
  def item_params
    params.require(:item).permit(:genre_id, :item_name, :introduction, :content_volume, :unit, :no_tax_price, :is_active)
  end
end
