class CreditCard < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :address, :city, :state, :zip, :number, :first_name, :last_name, :month, :year, :phone_number #, :verification_value
  validates_length_of :number, :within => 13..16,  :too_long => "your card number is too long", :too_short => "your card number is too short"
  #validates_numericality_of :year, :verification_value
  validates_numericality_of :month, :greater_than => 0, :less_than => 13
  validate :check_vv, :ensure_valid_date, :valid_card?

  before_save :kill_dcvv
  #before_save :check_vv

  def has_billing_details?
    if self.address.length > 4 and self.city.length > 2 and self.zip.length > 4 and self.state.length > 1
      return true
    else
      return false
    end
  end

  def kill_dcvv
    if self.number[0].chr == '6'
      self.verification_value = ''
    end
  end

  def check_vv
    if self.number[0] == 6
      self.verification_value = ''
    else
      if self.verification_value.length > 0 or self.verification_value.gsub(/[0-9]+/, '') == '' 
        return false
      else
        self.errors.add(:base, 'Please enter a valid verification value.')
      end
    end
    return true
  end

  def ensure_valid_date
    today = Date.today
    card_date = Date.new(self.year, self.month, 1)
    unless card_date > today
      self.errors.add(:base, 'Please make sure your credit card has not already expired.')
    end
  end

  def valid_card?
    #used to do credit card auth - but now we dont care
    return true
    if Rails.env.test? == 'test' or Rails.env.development? == 'development'
      test = true
    else
      test = false
    end
    ActiveMerchant::Billing::Base.mode = :production
    credit_card = create_active_merchant_card
    unless credit_card.valid?
      errors.add(:base, 'It appears this is not a valid credit card. Please double check the number and try again.')
      return 
    end
    gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
          :login    => '9vLbG97Lfg8',
          :password => '98g9574fkLeBmT8j',
          :test => test
        )
    billing_address = { :address => self.address, :city => self.city, :state => self.state, :zip => self.zip, :country => 'US', :phone => self.phone_number}
    response = gateway.authorize(rand(100) + 1, credit_card, {:billing_address => billing_address})
    ##used to do the following to validate address
    @ups = Shipping::UPS.new(:city => self.city, :state => self.state, :zip => self.zip)
    unless @ups.valid_address?
      errors.add(:base, 'You seem to have an invalid address. Please ensure you have the proper city, state, and zip.')
      return false
    end
    ######
    #avs_success = false
    #puts 'street match is ' + response.avs_result[:street_match]
    #if response.avs_result['street_match'] == 'Y'
    #  avs_success = true
    #end
    #if avs_success and response.success?
    #be nice if the avs success code worked - but it doesn't
    if response.success?
      return true
    else 
      errors.add(:base, 'We could not authorize your credit card. Please verify the details, and the billing address are correct, and please verify you are using Visa, MasterCard, Discover, Diners Club, or JCB.')
      return false
    end
  end

  def display_number
    credit_card = create_active_merchant_card
    credit_card.display_number
  end

  def create_active_merchant_card
    #cvv = self.verification_value
    #if self.verification_value == ''
    #  cvv = '123'
    #end
    credit_card = ActiveMerchant::Billing::CreditCard.new(
                  :first_name         => self.first_name,
                  :last_name          => self.last_name,
                  :number             => self.number,
                  :month              => self.month,
                  :year               => self.year,
                  :verification_value => self.verification_value
                )
  end
end
