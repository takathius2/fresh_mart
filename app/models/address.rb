class Address < ApplicationRecord
    belongs_to :customer
    belongs_to :order
    
    def address_display
        '〒' + postal_code + '' + address + '' + name
    end
end
