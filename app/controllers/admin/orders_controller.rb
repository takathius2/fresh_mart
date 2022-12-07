class Admin::OrdersController < ApplicationController
  def show
    @order_detail = Order.find(params[:id])
    @order = Order.find_by(id: params[:id])
    @customer = Customer.find_by(id: params[:id])
  end
  
  def update
    
  end
  
  #製作ステータスの更新
  def order_details_update
    
  end
  
  private
  def order_params
   params.require(:order).permit(:customer_id, :payment_method, :delivery_method, :cost_price, :price, :order_status, :delivery_address, :delivery_code, :delivery_name)
  end
  
  def order_detail_params
    params.require(:order_detail).permit(:item_id, :order_id, :price, :puroduct_status, :amount)
  end
end
