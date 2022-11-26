class HomesController < ApplicationController
  def top
    @item = Item.page(params[:page])
  end
end
