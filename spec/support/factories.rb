module Factories
  def create_user(attrs = {})
    attrs[:name]                            ||= "Pepe"
    attrs[:email]                           ||= "pepe@pepe.org"
    attrs[:password]                        ||= "secret12"
    attrs[:password_confirmation]           ||= "secret12"
    User.create!(attrs)
  end

  def create_product(attrs = {})
    attrs[:name]                            ||= "carrot"
    attrs[:stored_at]                       ||= Time.current
    attrs[:price]                           ||= 40
    attrs[:stock]                           ||= 25
    Product.create!(attrs)
  end
end
