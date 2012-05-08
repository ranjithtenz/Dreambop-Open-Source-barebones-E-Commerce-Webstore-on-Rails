class ShippingAddress < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :first_name, :last_name, :address1, :city, :state, :zip
  validate :valid_address

  #resets all the shipping address default settings to 0 for a user
  #TODO update in bulk
  def set_default!
    ShippingAddress.update_all('current_default = 0', 'user_id = ' + self.user_id.to_s)
    ShippingAddress.update(self.id, :current_default => true)
  end

  def valid_address
    #used to do this to validate address
    #@ups = Shipping::UPS.new(:city => self.city, :state => self.state, :zip => self.zip)
    #return if @ups.valid_address?
    #errors.add(:base, 'You seem to have an invalid address. Please ensure you have the proper city, state, and zip.')
  end
end
