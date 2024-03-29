class Address < ApplicationRecord
   belongs_to :customer
 
  # 宛先氏名・郵便番号・住所の記入漏れチェック
  validates :postal_name, presence: true, length: { minimum: 1 }
  validates :postal_name_kana, presence: true, length: { minimum: 1 }, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カタカナで入力してください。' }
  validates :postal_code, presence: true, length: { minimum: 7 }, format: { with: /\A\d{7}\z/, message: 'は半角数字で入力してください。' }
  validates :postal_address, presence: true, length: { minimum: 1 }
  validates :postal_telephone_number, presence: true, length: { minimum: 10, maximum: 11 }, format: { with: /\A\d{10,11}\z/, message: 'は半角数字で入力してください。' }

  def address_display
    '〒' + postal_code + '' + postal_address + '' + postal_name
  end
end
