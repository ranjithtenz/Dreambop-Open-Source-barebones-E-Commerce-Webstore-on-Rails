require 'digest/sha1'
require 'authenticated_system.rb'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  #include Authentication::ByCookieToken

  has_and_belongs_to_many :roles
  has_one :cart, :dependent => :destroy
  has_one :credit_card, :dependent => :destroy
  has_many :shipping_addresses, :dependent => :destroy
  has_one :shipping_address, :conditions => { :current_default => true}
  has_many :orders

  before_create :generate_activation_code

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email
  validates_format_of       :email,    :with => Authentication.email_regex, :message => Authentication.bad_email_message

   

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :email, :password, :password_confirmation



  def has_role?(type)
    rs = self.roles
    rs.each do |r|
      return true if r.name == type
    end
    return false
  end

  # Authenticates a user by their email and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    #old u = find_by_login(login.downcase) # need to get the salt
    u = find_by_email(email.downcase) # need to get the salt
    #should use this line - but for now
    #u && u.authenticated?(password) && u.activation_code == nil ? u : nil
    u && u.authenticated?(password) ? u : nil
  end

  def activate!
    self.activation_code = nil
    self.save
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def generate_activation_code
    self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join)
  end
  
  def reset_password!
    size = 6
    chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    self.password = (1..size).collect{|a| chars[rand(chars.size)] }.join
    self.password_confirmation = self.password
    UserMailer.deliver_new_password(self) 
    self.save
  end

  def remember_token?
    (!remember_token.blank?) && 
      remember_token_expires_at && (Time.now.utc < remember_token_expires_at.utc)
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    remember_me_for 2.weeks
  end

  def remember_me_for(time)
    remember_me_until time.from_now.utc
  end

  def remember_me_until(time)
    self.remember_token_expires_at = time
    self.remember_token            = self.class.make_token
    return false
  end

  # refresh token (keeping same expires_at) if it exists
  def refresh_token
    if remember_token?
      self.remember_token = self.class.make_token 
      return false
    end
  end

  # 
  # Deletes the server-side record of the authentication token.  The
  # client-side (browser cookie) and server-side (this remember_token) must
  # always be deleted together.
  #
  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

end
