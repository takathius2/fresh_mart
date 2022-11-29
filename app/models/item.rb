class Item < ApplicationRecord
    belongs_to :genre
    has_many :order_details, dependent: :destroy
    has_many :cart_items, dependent: :destroy
    
    
    #商品画像用のコード
    has_one_attached :item_image
    
     #消費税を求めるメソッド（10％
    def with_tax_price
        (no_tax_item_price*1.1).floor
    end
    
    
    
    def get_item_image(width, height)
        unless item_image.attached?
            file_path = Rails.root.join('app/assets/images/no_image.jpg')
            item_image.attach(io:File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        item_image.variant(resize_to_limit: [width, height]).processed
    end
end
