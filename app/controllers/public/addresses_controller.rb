class Public::AddressesController < ApplicationController
  def index
    @addresses = current_customer.addresses
  end

  def new
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create 
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    #  @address.customer_id = current_customer.id.where(customer: telephone_number)
    # ↑のように条件を付け加えることもできる
    if @address.save
      flash[:notice] = "配送先が新規作成されました。"
      redirect_to public_addresses_path
    else
      flash[:alart] = "配送先作成に失敗しました。"
      render :new
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      # flash[:notice] = "配送先の情報を更新しました。"
      redirect_to public_addresses_path
    else
      # flash[:alart] = "情報の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy!
    flash[:notice] = "配送先を１件削除しました。"
    redirect_to public_addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :postal_address, :postal_name, :postal_name_kana, :postal_telephone_number)
  end
end
