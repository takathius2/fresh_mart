Rails.application.routes.draw do
  #コントローラ作成時は＄rails g controller モデル名/複数形のアクション名 で行うこと！
  
  #管理者用
  #URL admin/sign_in...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  #顧客用
  #URL customers/sign_in...
  devise_for :customers, skip: [:passwords] ,controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
