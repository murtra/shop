require 'spec_helper'

describe Product do
  it 'decrements stock' do
    product = Product.create!(name: "chair", stored_at: Time.current, price: 40, stock: 25)
    
    expect {
      product.decrement_stock(5)
    }.to change { product.stock }.by(-5)
  end
end
           