# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  #ログインのcreateアクションの前に顧客が退会しているか調べる
  before_action :customer_state, only: [:create]
  
  protected
  
  #退会しているか調べるメソッド
  def customer_state
    #処理1：入力されたメールアドレスからアカウントを1件取得する
    @customer = Customer.find_by(email: params[:customer][:email])
    #処理2_1：アカウント取得失敗したらこのメソッドは終了
    return if !@customer
    
    #処理2_2:取得したアカウントのパスワードと入力されたパスワードが一致するか比べる
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted
      flash[:error] = "退会済みです。引き続き買い物を行うにはお手数ですが
      別のメールアドレスで新規会員登録を行ってください。"
      redirect_to new_customer_registration_path
    end
  end
end
