class Order < ApplicationRecord
    has_many :addresses, dependent: :destroy
    has_many :order_details, dependent: :destroy
    has_one :order_destination
    accepts_nested_attributes_for :order_destination
    belongs_to :customer
    
    validates :payment_method, presence: true
    validates :delivery_method, presence: true
    # validates :delivery_name, presence: true
    # validates :delivery_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください。' }
    # validates :delivery_code, presence: true, format: { with: /\A\d{7}\z/, message: 'は半角数字で入力してください。' }
    # validates :delivery_address, presence: true
   
    
    has_one_attached :item_image
    
    
    def get_item_image(width, height)
        unless item_image.attached?
            file_path = Rails.root.join('app/assets/images/no_image.jpg')
            item_image.attach(io:File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        item_image.variant(resize_to_limit: [width, height]).processed
    end
    
    
    #0ならクレジット払い、1なら銀行振込
    enum payment_method: { credit_card: 0, transfer: 1 }
    
    # 0なら顧客自身の住所、1なら既存の登録された配送先住所、２なら新規に配送先を登録した住所
    enum delivery_method: { my_address: 0, existing_delivery_address: 1, new_shipping_address: 2 }
    
    # 0なら入金待ち、１なら入金確認、２なら発送準備中、３なら発送完了
    enum order_status: { awaiting_payment: 0, payment_confirmation: 1, preparing_to_ship: 2, dispatched_completed: 3 }
end
