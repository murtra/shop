class OrderMailer < ActionMailer::Base
  default from: "murtra@murtra.net" 
  
  def order_created(order, user)
    @order = order
    mail to: user.email
  end 
end
