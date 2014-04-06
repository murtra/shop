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

  scope :with_category,     ->(category) { where("category = ?", category) }
  scope :with_stock,        ->(stock) { where("stock = ?", stock) }
  scope :stored_at,         ->(time) { where("stored_at = ?", time) }
  scope :with_manufacturer, ->(manufacturer) { where("manufacturer = ?", manufacturer) }
  scope :price_lower,       ->(price) { where("price <= ?", price) }
  scope :price_greater,     ->(price) { where("price >= ?", price) }

  def decrement_stock(num)
    self.stock -= num
    save
  end

end
