class Product < ActiveRecord::Base


  cattr_reader :per_page
  @@per_page = 24
  belongs_to :ds_vendor, :polymorphic => true
  belongs_to :category
  has_many :product_images, :order => 'width desc'
  has_one :product_image, :conditions => { :hero => true }

#  validates_uniqueness_of :title
  DS_VENDORS = [ 'Dsdi' ]
  BUCKET = 'buymeyo_prod'

  before_save :sanitize_manufacturer

  def sanitize_manufacturer
    self.manufacturer = Product.sanitize(self.manufacturer)
  end

  def self.sanitize(name)
    name = name.gsub(/[^0-9A-Za-z]|[ ]+/, ' ')
    name = name.gsub(/ +/, ' ')
    return name
  end

  def not_na?
    case self.availability
      when 'Yes'
        return true
      when 'No'
        return true
      else
        return false
    end
  end

  def display_availability
    case self.availability
      when 'Yes'
        return 'Yes'
      when 'No'
        return 'No'
      else
        return 'NA'
    end
  end

  def image_width
    width = 300
    i = ProductImage.find(:first, :conditions => {:product_id => self.id, :thumbnail => false})
    width = i.width unless i.nil?
    return width
  end

  def image(size = nil)
    if self.ds_vendor_type == 'DandhProduct' or self.ds_vendor_type == 'DsdiProduct'
      case size
        when nil
          location = 'https://s3.amazonaws.com/' + BUCKET + '/' + self.title.parameterize.to_s + '.jpg'
        when 75
          location = 'https://s3.amazonaws.com/' + BUCKET + '/' + self.title.parameterize.to_s + '.jpg'
        when 150
          location = 'https://s3.amazonaws.com/' + BUCKET + '/' + self.title.parameterize.to_s + '-x150.jpg'
        when 300
          location = 'https://s3.amazonaws.com/' + BUCKET + '/' + self.title.parameterize.to_s + '.jpg'
        end
      return location
    end
    i = nil
    case size
      when nil
        i = self.product_images.detect { |pi| pi.thumbnail == false }
      when 75
        i = self.product_images.detect { |pi| pi.width == '75'}
      when 150
        i = self.product_images.detect { |pi| pi.width == '150'}
      when 300
        i = self.product_images.detect { |pi| pi.width == '300'}
    end
    if i.nil?
        i = self.product_images.first #find(:first, :conditions => {:order => 'width desc'})
    end
    if i.nil?
      case size
        when nil
          return 'no_image.jpg'
        when 75
          return 'no_image-x75.jpg'
        when 150
          return 'no_image-x150.jpg'
        when 300
          return 'no_image.jpg'
      end
    else
      i.public_filename
    end
  end

  def imagex75 
    location = 'https://s3.amazonaws.com/' + BUCKET + '/' + self.title.parameterize.to_s + '-x75.jpg'
  end

  def imagex150 
    location = 'https://s3.amazonaws.com/' + BUCKET + '/' + self.title.parameterize.to_s + '-x150.jpg'
  end

  def old_image
    location = 'https://s3.amazonaws.com/' + BUCKET + '/' + self.title.parameterize.to_s + '.jpg'
  end

  def to_param
    #slug
    link = title.parameterize
    #do this after images are in DB
    #size = link.size
    #if size > 80
    #  size = 80
    #end
    #link = link[0, size - 1]
    "#{id}-#{link}"
  end

  FIVEHUNDRED = ['purchase a new computer', 'buy a new hd tv', 'buy a used car', 'purchase a set of new tires' ]
  THREEHUNDRED = ['buy a new tv', 'buy a new computer monitor', 'buy a really nice external hard drive']
  TWOHUNDRED = ['take your family out to dinner', 'take a few friends to sushi', 'buy an external hard drive for all those movies and mp3s!']
  ONEHUNDRED = ['buy an upgrade of ram for your computer', 'buy a weeks worth of groceries' ]
  FIFTY = ['buy a new video game', 'get an oil change', 'treat a friend to some thai food', 'treat yourself to some sushi', 'buy a tank of gas' ]
  FORTY = [ 'go to a really nice resturant', 'treat a friend to some takeout', 'go to a concert']
  THIRTY = ['treat a friend to some takeout', 'buy a friend some flowers']
  TWENTY = ['take a friend out to a movie', 'order some pizzas', 'buy a new dvd']
  TEN = ['buy a sixpack', 'go to a movie', 'buy a new album', 'buy a new dvd', 'take yourself out to lunch' ]
  FIVE = ['purchase a tasty sub sandwich', 'take yourself out to lunch']
  THREE = ['buy a pack of potato chips', 'buy a bottle of wine', 'buy a breakfast bar']
  TWO = ['buy yourself some candy', 'purchase an ice cream bar',  'buy a protein bar']
  ONE = ['purchase a tasty beverage', 'buy an ice cream bar']
  ZERO = ['leave some change on the counter for a rainy day']

  AMOUNTS = {500 => FIVEHUNDRED, 300 => THREEHUNDRED, 200 => TWOHUNDRED, 100 => ONEHUNDRED, 50 => FIFTY, 40 => FORTY, 30 => THIRTY, 20 => TWENTY, 10 => TEN, 5 => FIVE, 3 => THREE, 2 => TWO, 1 => ONE, 0 => ZERO}

  def saved_comp
    saved = self.msrp - self.price
    pick = ZERO
    ar_pick = 0
    am = AMOUNTS.sort.reverse
    am.each do |key, val|
      if saved >= key
        ar_pick = val
      end
      break if saved >= key
    end
    size = ar_pick.size
    pick = rand(size)
    return ar_pick[pick]
  end

  def price
    my_price = self.reseller_price
    if my_price > 500
      if self.ds_vendor_type == 'IngramMicroProduct'
        my_price = ((self.reseller_price * 1.05) + 3.3).ceil - 0.01
      else
        my_price = ((self.reseller_price * 1.05) + 0.3).ceil - 0.01
      end
    else
      if self.ds_vendor_type == 'IngramMicroProduct'
        my_price = ((self.reseller_price * 1.08) + 10.3).ceil - 0.01
      else
        my_price = ((self.reseller_price * 1.08) + 0.3).ceil - 0.01
      end
    end
    if my_price < self.map
      return self.map
    end
    return my_price
  end

  def old_price
    my_price = ((self.reseller_price * 1.05) + 0.3).ceil - 0.01 
    if my_price < self.map
      return self.map
    end
    return my_price
  end

  def staggered_price
    my_price = self.reseller_price
    if my_price > 14000     #700
      my_price *= 1.05
    elsif my_price > 13000  #790
      my_price *= 1.06
    elsif my_price > 12000  #840
      my_price *= 1.07
    elsif my_price > 11000  #880
      my_price *= 1.08
    elsif my_price > 10000  #900 
      my_price *= 1.09
    elsif my_price > 9000   #900
      my_price *= 1.10
    elsif my_price > 8000   #960
      my_price *= 1.12
    elsif my_price > 7000   #980
      my_price *= 1.14
    elsif my_price > 6000   #960
      my_price *= 1.16
    elsif my_price > 5000   #900
      my_price *= 1.18
    elsif my_price > 4000   #760
      my_price *= 1.19
    elsif my_price > 3000   #600
      my_price *= 1.2
    elsif my_price > 70    #140
      my_price *= 1.2
    elsif my_price > 50     #17.5
      my_price *= 1.3
    elsif my_price > 10     #10
      my_price *= 1.40 
    elsif my_price <= 10    #2.50
      my_price *= 1.5
    end
    if self.msrp < my_price
      my_price = self.msrp - (0.1 * self.msrp)
    end
    return self.map if my_price < self.map
    return my_price
  end

  def remote_id
    if self.ds_vendor_type == 'DsdiProduct'
      return self.ds_vendor.model
    else
      return ''
    end
  end
  #before_create :create_slug
  #def create_slug
  #  self.slug = self.title.parameterize
  #end

end
