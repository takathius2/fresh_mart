class Order < ApplicationRecord
    has_many :addresses, dependent: :destroy
    has_many :order_details, dependent: :destroy
    belongs_to :customer
    
    validates :payment_method, presence: true
    #validates :delivery_method, presence: true
    
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
    
end
