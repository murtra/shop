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

  scope :with_category,     ->(category)     {
                                               return if category.blank?
                                               where(category: category)
                                             }
  scope :with_stock,        ->(stock)        {
                                                return if stock.blank?
                                                where(stock: stock)
                                             }
  scope :stored_at,         ->(time)         {
                                                return if time.blank?
                                                where(time: time)
                                             }
  scope :with_manufacturer, ->(manufacturer) {
                                               return if manufacturer.blank?
                                               where(manufacturer: manufacturer)
                                             }
  scope :minimum_price,     ->(price)        {
                                              return if price.blank?
                                              where("price >= ?", price)
                                             }    
  scope :maximum_price,     ->(price)        {
                                             return if price.blank?
                                             where("price <= ?", price)
                                             }                                           
  

  def decrement_stock(num)
    self.stock -= num
    save
  end

  def self.filter(params)
    products = Product.all
    products = products.with_category(params[:category])
    products = products.with_stock(params[:stock])
    products = products.stored_at(params[:stored_at])
    products = products.with_manufacturer(params[:manufacturer])
    products = products.minimum_price(params[:minimum_price])
    products = products.maximum_price(params[:maximum_price]) 

    products
  end
end
