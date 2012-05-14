class Manufacturer < ActiveRecord::Base
  attr_accessible :name, :url
  has_many :products

  def sanitize
    self.name = Product.sanitize(self.name)
  end

  def to_param
    #slug
    link = name.parameterize
    #do this after images are in DB
    #size = link.size
    #if size > 80
    #  size = 80
    #end
    #link = link[0, size - 1]
    "#{id}-#{link}"
  end
end
