class CartProduct < ActiveRecord::Base
  attr_accessible :cart, :product_id
  belongs_to :cart
  belongs_to :product
end
