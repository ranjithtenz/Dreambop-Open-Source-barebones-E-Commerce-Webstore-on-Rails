class OrderProduct < ActiveRecord::Base
  attr_accessible :order, :order_id, :product, :product_id
  belongs_to :order
  belongs_to :product
end
