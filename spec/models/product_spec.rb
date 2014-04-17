require 'spec_helper'

describe Product do
  it 'decrements stock' do
    product = create_product
    
    expect {
      product.decrement_stock(5)
    }.to change { product.stock }.by(-5)
  end
end
           