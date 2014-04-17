require 'spec_helper'

describe Order do
  it 'calculates total price' do
    carrot = Product.create!(name: "carrot", stored_at: Time.current, price: 40, stock: 25)
    potato = Product.create!(name: "potato", stored_at: Time.current, price: 22, stock: 57)

    order =  Order.create!(name: "Almudena", last_name: "Garcia", address: "Av. Lluis Pericot, 47", city: "Girona", payment_mode: "paypal")

    line_item_1 =  order.line_items.create!(quantity: 2, product: carrot)
    line_item_2 =  order.line_items.create!(quantity: 1, product: potato)

    expect(order.total_price).to eq(102)
  end
end
