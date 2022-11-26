class Admin::HomesController < ApplicationController
  def top
    @orders = Order.page(params[:page])
    @order_details = OrderDetail.all
  end
end
