class Product < ActiveRecord::Base
  ALLOWED_CATEGORIES = [ "books", "music - movies", "electronics", "home", "toys", "clothing", "food" ]

  validates :name, presence: true, length: { maximum: 255 }
  validates :stored_at, :stock, :price, presence: true
  validates :price, numericality: true
  validates :stock, numericality: { only_integer: true }
  validates :category, inclusion: { in: Product::ALLOWED_CATEGORIES, allow_blank: true,
      message: "is not valid" }
  validates :name, uniqueness: true

  has_many :line_items
  has_many :orders, through: :line_items

  def decrement_stock(num)
    self.stock -= num
    save
  end

end
