class CartItem < ApplicationRecord
    belongs_to :item
    belongs_to :customer
    
    has_one_attached :item_image
    
    def get_item_image(width, height)
        unless item_image.attached?
            file_path = Rails.root.join('app/assets/images/no_image.jpg')
            item_image.attach(io:File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
        end
        item_image.variant(resize_to_limit: [width, height]).processed
    end
    #小計を求めるメソッド
    def subtotal
        item.with_tax_price * amount
    end
end
