class Order < ActiveRecord::Base
  attr_accessor :paypal_details
  belongs_to :user
  belongs_to :credit_card
  belongs_to :shipping_address
  has_many :order_products, :dependent => :destroy
  has_many :products, :through => :order_products

  STATUSES = ["Could not be charged", "Successfully charged to gateway", "Cancelled", "Tracking number sent", "Shipment Received"]

  validates_presence_of :tax_cost, :shipping_cost, :subtotal, :total_cost, :user_id, :shipping_address_id #, :credit_card_id
  validates_numericality_of :tax_cost, :shipping_cost, :subtotal, :total_cost

  before_validation(:on => :create) do 
    load_checkout_totals
    set_user_details
  end
  after_validation(:on => :create) do 
    submit_to_gateway
  end

  after_create :add_ordered_products, :reset_cart, :email_users

  def email_users 
    #OrderMailer.deliver_ordered(self) 
    #OrderMailer.deliver_ordered_admin(self) 
  end

  def cancel
    auth_id = self.transaction_number #status.split(/(\d+)/)[1]
    ActiveMerchant::Billing::Base.mode = :production
    test = false
    gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
          :login    => 'authnetlogin',
          :password => 'authnetpassword',
          :test => test
        )
    resp = gateway.void(auth_id)
    #return resp
    if(resp.message == 'This transaction has been approved')
      self.status = "Cancelled" # (" + auth_id + ')'
    else
      card_number = self.credit_card.number
      amount = (self.total_cost * 100).to_i
      gateway.credit( amount, auth_id, :card_number => card_number)
      self.status = "Cancelled" # (" + auth_id + ')'
    end
    self.save
  end

  def process_paypal
    self.credit_card_id = 0
    self.status = "Paypal Success: authorization_id (" + self.paypal_details[:authorization_id] + ")\n" 
    address = self.paypal_details[:address]
    self.status = self.status + '[' + address['first_name'].to_s + ' ' + address['last_name'].to_s + "\n" + address['street1'].to_s + "\n" + address['street2'].to_s + "\n" + address['city_name'].to_s  + ", " + address['postal_code'].to_s + " " + address['country'].to_s + "]"
  end

  def submit_to_gateway
    process_paypal and return true unless self.paypal_details.blank? 
    if Rails.env.test? == 'test' or Rails.env.development? == 'development'
      test = true
    else
      test = false
    end
    ActiveMerchant::Billing::Base.mode = :production
    am_credit_card = self.credit_card.create_active_merchant_card
    #The Authorize.Net API Login ID
    #The Authorize.Net Transaction Key.
    #gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
    #  :login    => '838383',  
    #  :password => '9383838'
    #)
    #gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
    #  :login    => '9vLbG97Lfg8',  
    #  :password => '98g9574fkLeBmT8j',
    #  :test => test
    #)
    gateway_total = (self.total_cost * 100).to_i
    #add this shit later
    #shipping_address = {:first_name => 'ANITA', :last_name => 'GANS', :address1 => '8812 NORTH 114TH AVE', :city => 'PEORIA', :zip => '85345', :state => 'AZ'}
    #response = gateway.authorize(gateway_total, credit_card, :billing_address => shipping_address)
    billing_address = { :address => self.credit_card.address, :city => self.credit_card.city, :state => self.credit_card.state, :zip => self.credit_card.zip, :country => 'US', :phone => self.credit_card.phone_number}
    #response = gateway.authorize(gateway_total, am_credit_card, {:billing_address => billing_address})
    if true #response.success?
      #gateway.capture(gateway_total, response.authorization)
      self.status = STATUSES[1]
      self.transaction_number = "not capturing auth here" #response.authorization.to_s
    else
      #self.status = STATUSES[0] + ': ' + response.message
      errors.add(:base, 'We are sorry but your credit card could not be charged for some reason. Please contact us if this problem persists')
      #raise StandardError, response.message 
    end
  end

  def set_user_details
    self.credit_card = self.user.credit_card
    self.shipping_address = self.user.shipping_address
  end

  def load_checkout_totals
    checkout = Checkout.new(self.user)
    self.tax_cost = checkout.tax
    self.shipping_cost = checkout.shipping_cost
    self.subtotal = checkout.subtotal
    self.total_cost = checkout.total
  end

  def add_ordered_products
    self.user.cart.products.each do |product|
      op = OrderProduct.create(:order => self, :product => product)
    end  
  end
  
  def reset_cart
    self.user.cart.remove_contents!
  end

end
