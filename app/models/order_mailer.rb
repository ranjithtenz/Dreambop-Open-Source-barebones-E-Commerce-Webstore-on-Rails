class OrderMailer < ActionMailer::Base
  def ordered(order)
     recipients order.user.email
     bcc        "support@yourdomain.com"
     from       "orders@yourdomain.com"
     subject    "Your receipt for shopping with MyDomain"
     body       :order => order
   end
  def ordered_admin(order)
     recipients "orders@yourdomain.com"
     from       "orders@yourdomain.com"
     subject    "New Order made"
     body       :order => order
   end
end
