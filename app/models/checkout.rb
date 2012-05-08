require 'active_shipping'
include ActiveMerchant::Shipping

class Checkout

  attr_accessor :shipping_cost, :tax, :total, :subtotal

  WEST = ["Washington", "Oregon", "California", "Idaho", "Nevada", "Montana", "Wyoming", "Utah", "Arizona", "Colorado", "New Mexico"]
  CENTRAL = ["North Dakota", "South Dakota", "Nebraska", "Kansas", "Oklahoma", "Texas", "Minnesota", "Iowa", "Missouri", "Arkansas", "Louisiana", "Wisconsin", "Illinois", "Michigan", "Indiana", "Ohio"]
  EAST = [ "Kentucky", "Tennessee", "Mississippi", "Alabama", "West Virginia", "Virginia", "North Carolina", "South Carolina", "Georgia", "Florida", "Maine", "New Hampshire", "Vermont",  "Massachusetts", "New York", "Pennsylvania", "Maryland", "Rhode Island", "Connecticut", "New Jersey", "Delaware"]

  def initialize(user, session_id=nil, shipping_address=nil)
    if user.nil?
      if shipping_address.nil?
        @shipping_cost = 0
        @subtotal = 0 
        @cart = Cart.find_by_session_id(session_id)
        if @cart
          @cart.products.each do |product|
            @subtotal += product.price
          end
        end
        @tax = 0
        @total = @subtotal + @shipping_cost + @tax
      else
        @cart = Cart.find_by_session_id(session_id)
        @address = shipping_address
        calculate_shipping_subtotal
        calculate_tax
        @total = @subtotal + @shipping_cost + @tax
      end
    else
      @address = user.shipping_address
      if shipping_address.nil? and @address.nil?
        @shipping_cost = 0
        @subtotal = 0 
        @cart = user.cart
        @subtotal = 0
        if @cart
          @cart.products.each do |product|
            @subtotal += product.price
          end
        end
        @tax = 0
        @total = @subtotal + @shipping_cost + @tax
      else
        @user = user
        @cart = user.cart
        calculate_shipping_subtotal
        calculate_tax
        @total = @subtotal + @shipping_cost + @tax
      end
    end
  end

private
  def calculate_shipping_subtotal
    total_weight = 0
    @subtotal = 0.0
    total_ship_cost = 0.0
    return if @cart.nil?
    products = @cart.products
    destination = Location.new( :country => 'US',
                            :state => STATE_CODES[@address.state.upcase],
                            :city => @address.city,
                            :postal_code => @address.zip)
    products.each do |product|
      @subtotal += product.price
      unless @address.nil?
      #http://github.com/Shopify/active_shipping
      #try this instead
      sender_zip = '97367'
      if product.ds_vendor.class == DandhProduct
        sender_zip = '17101' #harrisburg PA
        if EAST.include?(@address.state)
          sender_zip = '93650' #fresno ca
        end
      end
      #puts 'sender zip is ' + sender_zip
        #ups = Shipping::UPS.new(:city => @address.city, :state => @address.state, :zip => @address.zip, :sender_zip => sender_zip, :weight => product.weight, :ups_license_number => 'F0F0F0F0F0F0F0', :ups_user => 'thedude', :ups_password => 'whiterussian',  :service_type => '3day', :packaging_type => 'your_packaging')
        #total_ship_cost += #ups.price
        origin = Location.new(      :country => 'US',
                            #:state => 'CA',
                            #:city => 'Beverly Hills',
                            :zip => sender_zip)
       packages = [
                        Package.new(  (product.weight * 16),                 # 7.5 lbs, times 16 oz/lb.
                                      #[15, 10, 4.5],              # 15x10x4.5 inches
                                      [],              # 15x10x4.5 inches
                                      :units => :imperial)        # not grams, not centimetres
        ]


        #ups = UPS.new(:login => 'thedude', :password => 'whiterussian', :key => '0404040404040404')
        #response = ups.find_rates(origin, destination, packages)
        #ups_rates = response.rates.sort_by(&:price).collect {|rate| [rate.service_name, rate.price]}
        #total_ship_cost += (ups_rates.first[1] / 100) + 5
      else
        total_ship_cost = 0
      end
    end
    @shipping_cost = total_ship_cost
  end

  def calculate_tax
    @tax = 0
    unless @address.nil?
      if @address.state == 'California' or @address.state == 'CA'  
        @tax = (@subtotal + @shipping_cost) * 0.0825 
      end
    end
  end
  STATE_CODES = {
    'ALABAMA' => 'AL',
    'ALASKA' => 'AK',
    'AMERICAN SAMOA' => 'AS',
    'ARIZONA' => 'AZ',
    'ARKANSAS' => 'AR',
    'CALIFORNIA' => 'CA',
    'COLORADO' => 'CO',
    'CONNECTICUT' => 'CT',
    'DELAWARE' => 'DE',
    'Washington  D.C.' => 'DC',
    'FEDERATED STATES OF MICRONESIA' => 'FM',
    'FLORIDA' => 'FL',
    'GEORGIA' => 'GA',
    'GUAM' => 'GU',
    'HAWAII'  => 'HI',
    'IDAHO' => 'ID',
    'ILLINOIS' => 'IL',
    'INDIANA' => 'IN',
    'IOWA' => 'IA',
    'KANSAS' => 'KS',
    'KENTUCKY' => 'KY',
    'LOUISIANA' => 'LA',
    'MAINE' => 'ME',
    'MARSHALL ISLANDS' => 'MH',
    'MARYLAND' => 'MD', 
    'MASSACHUSETTS' => 'MA',
    'MICHIGAN' => 'MI',
    'MINNESOTA' => 'MN',
    'MISSISSIPPI' => 'MS',
    'MISSOURI' => 'MO',
    'MONTANA' => 'MT',
    'NEBRASKA' => 'NE',
    'NEVADA' => 'NV',
    'NEW HAMPSHIRE'  => 'NH',
    'NEW JERSEY'  => 'NJ',
    'NEW MEXICO' => 'NM',
    'NEW YORK' => 'NY',
    'NORTH CAROLINA' => 'NC',
    'NORTH DAKOTA' => 'ND',
    'NORTHERN MARIANA ISLANDS' => 'MP',
    'OHIO'  => 'OH',
    'OKLAHOMA' => 'OK',
    'OREGON'  => 'OR',
    'PALAU' => 'PW',
    'PENNSYLVANIA' => 'PA',
    'PUERTO RICO' => 'PR',
    'RHODE ISLAND' => 'RI',
    'SOUTH CAROLINA' => 'SC',
    'SOUTH DAKOTA' => 'SD',
    'TENNESSEE' => 'TN',
    'TEXAS' => 'TX',
    'UTAH' => 'UT',
    'VERMONT' => 'VT',
    'VIRGIN ISLANDS' => 'VI',
    'VIRGINIA' => 'VA',
    'WASHINGTON' => 'WA',
    'WEST VIRGINIA' => 'WV',
    'WISCONSIN' => 'WI',
    'WYOMING' => 'WY'
    }

end
