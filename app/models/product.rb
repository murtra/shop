class Product < ActiveRecord::Base

  validates :name, presence: true, length: { maximum: 255 }
  has_many :line_items
  has_many :orders, through: :line_items

end
