class OrderDetail < ApplicationRecord
    belongs_to :order
    belongs_to :item
    
    # 製品状況：０なら商品入荷待ち（取り寄せ中）、1なら準備中、２なら準備完了
    enum puroduct_status: { awaiting_delivery_of_goods: 0, in_preparation: 1, goods_ready: 2}
end
