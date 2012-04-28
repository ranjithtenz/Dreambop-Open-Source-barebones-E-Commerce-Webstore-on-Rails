class DandhProduct < ActiveRecord::Base
  belongs_to :spex_essential_product
  has_one :product, :as => :ds_vendor
  validates_uniqueness_of :name
end
