class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to public_my_page_path
    else
      render :edit
    end
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: :true)
    if @customer.is_deleted == false
      redirect_to public_customers_infomation_edit_path
    else
      #@customer.update(is_deleted: false)
      reset_session
      redirect_to '/' 
    end
  end

  def unsubscribe
    @customer = current_customer
    @customer.is_deleted = current_customer.is_deleted
  end
 
 private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, 
    :first_name_kana, :telephone_number, :postal_code, :address,
    :email, :password, :is_deleted)
  end
end
