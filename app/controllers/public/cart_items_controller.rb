class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @items = Item.page(params[:page])
    # 合計金額の初期値は0円
    @total = 0
  end

  def create
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])

    if @cart_item
      # カートにitemが存在したらamountに新しいCart_itemのamountを足す
      @cart_item.amount += CartItem.new(cart_item_params).amount
    else
      # カートにitemが無ければ新しく作成する
      @cart_item = CartItem.new(cart_item_params)
    end
    # ログインcustomerのみ更新できるようにするため分岐の外に記述する
    if @cart_item.customer = current_customer
      p @cart_item
      @cart_item.save!
      redirect_to public_cart_items_path
    else
      redirect_to new_customer_session_path
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @item = Item.all
    @cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy!
    flash.now[:notice] = "商品を一件削除しました。"
    redirect_to public_cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
