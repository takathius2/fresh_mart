class Public::AddressesController < ApplicationController
  def index
    @addresses = Address.all
  end
  
  def new
    @address = Address.new
  end
  
  def create
    @address = Address.new(address_params)
    if @address.save
      flash[:notice] = "配送先が新規作成されました"
      redirect_to public_addresses_path
    else
      flash[:alart] = "必須項目をすべて入力してください"
      render :new
    end
  end
  
  def edit
    @address =　Address.find(params[:id])
  end
  
  def upsdate
    @address =　Address.find(params[:id])
    @address.update(address_params)
    redirect_to public_addresses_path
  end
  
  def destroy
  
  end
  
  private
  def address_params
    params.require(:address).permit(:customer_id, :postal_code, :postal_address, :postal_name, :postal_name_kana, :postal_telephone_number)
  end
end
