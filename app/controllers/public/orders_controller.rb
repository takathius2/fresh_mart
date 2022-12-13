class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new #注文情報・支払方法入力画面
    @order = Order.new
  end

  def comfirm #注文情報確認画面HTTPメソッド:POST
    @order = Order.new(order_params)
    # binding.pry
    # 配送先が自分の住所の時（0）の処理
    if params[:order][:delivery_method] == Order.delivery_methods.key(0)
      # ログイン中の顧客自身のデータを@orderに代入していく
        @order = Order.new(order_params)
        @order.delivery_name = current_customer.full_name
        @order.delivery_name_kana = current_customer.full_name_kana
        @order.delivery_code = current_customer.postal_code
        @order.delivery_address = current_customer.address
    
    # 配送先が登録済み住所から選択された時（1）の処理
    elsif params[:order][:delivery_method] == Order.delivery_methods.key(1)
      # orderのaddress_idで登録されている配送先を選び、そのデータを@orderに代入していく
      @address = Address.find(params[:order][:address_id])
      @order.delivery_name = @address.postal_name
      @order.delivery_name_kana = @address.postal_name_kana
      @order.delivery_code = @address.postal_code
      @order.delivery_address = @address.postal_address
      @order.delivery_telephone_number = @address.postal_telephone_number
      
    # 配送先を新しく作成する時（2）の処理
    elsif params[:order][:delivery_method] == Order.delivery_methods.key(2)
      # 入力フォームから送られたデータを受け取り代入していく
      @order.delivery_name = params[:order][:delivery_name]
      @order.delivery_name_kana = params[:order][:delivery_name_kana]
      @order.delivery_code = params[:order][:delivery_code]
      @order.delivery_address = params[:order][:delivery_address]
      
    #else
      #render :new
    end
    
    @customer = current_customer
    @cart_items = current_customer.cart_items
    
    # 合計金額を出す（税込）
    @total_price = 0
    @cart_items.each do |cart_item|
      price = cart_item.item.with_tax_price
      @total_price += price
    end
    
   
    @total = 0
    @order.cost_price = 800
    @order.customer = current_customer 
    
    if @order.save
      render :comfirm
    else
      render :new
    end
  end
  
  def create #注文確定処理HTTPメソッド：POST
    @order = current_customer.orders.new(order_params)
    if @order.save!
      current_customer.cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order_id = @order.id
        order_detail.item_id = cart_item.item_id
        order_detail.amount = cart_item.amount
        order_detail.amount_billed_or_claimed = @order.amount_billed_or_claimed
        order_detail.save!
      end
      current_customer.cart_items.destroy_all
      redirect_to public_complete_path
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def complete #注文完了画面
  end
  

  def index #注文履歴
    @customer = current_customer.cart_items
    @orders = current_customer.orders.page(params[:page])
    @order_detail = OrderDetail.all
    @item = Item.all
    @address = Address.all
    @total = 0
  end

  def show #注文履歴詳細画面
    @order = Order.find(params[:id])
    @customer = current_customer.cart_items
    @order_detail = @order.order_details
    @total = 0
   
  end
  
  private
  def order_params
    params.require(:order).permit(:customer_id, :address_id, :payment_method, :delivery_telephone_number, :delivery_method, :cost_price,
    :amount_billed_or_claimed, :order_status, :delivery_address, :delivery_code, :delivery_name, :delivery_name_kana)
  end
  
end
