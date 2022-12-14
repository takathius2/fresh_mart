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
  
  root to: 'homes#top', as: 'top'
  get "homes/about" => "homes#about", as: "about"
  namespace :public do
    # 顧客情報関連
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    get 'customers/infomation/edit' => 'customers#edit'
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/infomation/update' => 'customers#update'
    patch 'customers/withdraw' => 'customers#withdraw'
    
    # 注文関連
    post 'orders/comfirm' => 'orders#comfirm'
    get 'orders/complete' => 'orders#complete', as: 'complete'
    resources :orders, only:[:new, :create, :index, :show] do
      resources :order_destinations
    end
    
    # カテゴリー関連
    resources :categories, only:[:index]
    
    # 配送先
    resources :addresses, only:[:index, :edit, :new, :create, :update, :destroy]
    resources :items, only:[:index, :show]
    resources :cart_items, only:[:index, :update, :destroy, :create]
  end
  
  namespace :admin do
    root 'homes#top'
    resources :categories, only: [:index, :create, :edit, :destroy, :update]
    resources :order_details, only: [:update]
    resources :orders, only:[:show, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :destroy, :update]
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
