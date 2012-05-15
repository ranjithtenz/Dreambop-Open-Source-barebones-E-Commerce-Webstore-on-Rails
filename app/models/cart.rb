class Cart < ActiveRecord::Base 

  attr_accessible :user, :user_id, :session_id

  belongs_to :user
  has_many :cart_products, :dependent => :destroy
  has_many :products, :through => :cart_products

  def remove_contents!
    self.cart_products.destroy_all
  end

end
#changed
