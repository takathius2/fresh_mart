class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
    @genres = Genre.all
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to admin_items_path
    else
      @genres = Genre.all
      render :new
    end
  end
  
  def index
    @items = Item.page(params[:page])
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
  
  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_items_path
  end
  
  private 
  def item_params
    params.require(:item).permit(:item_name, :item_image, :introduction, :no_tax_item_price, :genre_id, :content_volume, :unit)
  end
  
end
