class Address < ApplicationRecord
    belongs_to :customer
    belongs_to :order
    
    # 宛先氏名・郵便番号・住所の記入漏れチェック
    validates :postal_name, presence: true
    validates :postal_name_kana, presence: true
    validates :postal_code, presence: true
    validates :postal_address, presence: true
    validates :postal_telephone_number, presence: true
    
    def address_display
        '〒' + postal_code + '' + postal_address + '' + postal_name
    end
    
end
