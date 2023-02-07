class Admin::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page])
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end  

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "商品を新規登録しました。"
      redirect_to admin_items_path
    else
      @genres = Genre.all
      @items = Item.page(params[:page])
      flash.now[:danger] = "商品の登録に失敗しました。"
      render :new
    end
  end  
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "商品情報を更新しました。"
      redirect_to admin_items_path
    else
      flash.now[:danger] = "商品情報の更新に失敗しました。"
      render :show
    end
  end
  
  private 
  def item_params
    params.require(:item).permit(:item_name, :item_image, :introduction, :no_tax_item_price, :genre_id, :content_volume, :unit)
  end
  
end
