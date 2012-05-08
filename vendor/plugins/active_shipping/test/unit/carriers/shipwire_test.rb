require 'test_helper'

class ShipwireTest < Test::Unit::TestCase

  def setup
    @packages  = TestFixtures.packages
    @locations = TestFixtures.locations
    @carrier   = Shipwire.new(:login => 'l', :password => 'p')
    @items = [ { :sku => 'AF0001', :quantity => 1 }, { :sku => 'AF0002', :quantity => 2 } ]
  end
  
  def test_invalid_credentials
    @carrier.expects(:ssl_post).returns(xml_fixture('shipwire/invalid_credentials_response'))
    
    begin
      @carrier.find_rates(
        @locations[:ottawa],
        @locations[:beverly_hills],
        @packages.values_at(:book, :wii),
        :order_id => '#1000',
        :items => @items
      )
    rescue ResponseError => e
      assert_equal "Could not verify Username/EmailAddress and Password combination", e.message
    end
  end
  
  def test_response_with_no_rates_is_unsuccessful
    @carrier.expects(:ssl_post).returns(xml_fixture('shipwire/no_rates_response'))

    assert_raises(ResponseError) do
      response = @carrier.find_rates(
                   @locations[:ottawa],
                   @locations[:beverly_hills],
                   @packages.values_at(:book, :wii),
                   :order_id => '#1000',
                   :items => @items
                 )
    end
  end
  
  def test_successfully_get_international_rates
    date = DateTime.new(2011, 8, 1)
    DateTime.expects(:now).returns(date).at_least_once
    @carrier.expects(:ssl_post).returns(xml_fixture('shipwire/international_rates_response'))
    
    response = @carrier.find_rates(
                 @locations[:ottawa],
                 @locations[:london],
                 @packages.values_at(:book, :wii),
                 :order_id => '#1000',
                 :items => @items
               )
               
    assert response.success?
    
    assert_equal 1, response.rates.size
    
    assert international = response.rates.first
    assert_equal "INTL", international.service_code
    assert_equal "UPS", international.carrier
    assert_equal "UPS Standard", international.service_name
    assert_equal 2806, international.total_price
    assert_equal date + 7, international.delivery_date
    assert_equal [date + 1, date + 7], international.delivery_range
  end

  def test_successfully_get_domestic_rates
    date = DateTime.new(2011, 8, 1)
    DateTime.expects(:now).returns(date).at_least_once
    @carrier.expects(:ssl_post).returns(xml_fixture('shipwire/rates_response'))
    
    response = @carrier.find_rates(
                 @locations[:ottawa],
                 @locations[:beverly_hills],
                 @packages.values_at(:book, :wii),
                 :order_id => '#1000',
                 :items => @items
               )
               
    assert response.success?
    
    assert_equal 3, response.rates.size
    
    assert ground  = response.rates.find{|r| r.service_code == "GD" }
    assert_equal "UPS", ground.carrier
    assert_equal "UPS Ground", ground.service_name
    assert_equal 773, ground.total_price
    assert_equal date + 7, ground.delivery_date
    assert_equal [date + 1, date + 7], ground.delivery_range

    assert two_day = response.rates.find{|r| r.service_code == "2D" }
    assert_equal "UPS", two_day.carrier
    assert_equal "UPS Second Day Air", two_day.service_name
    assert_equal 1364, two_day.total_price
    assert_equal date + 2, two_day.delivery_date
    assert_equal [date + 2, date + 2], two_day.delivery_range
        
    assert one_day = response.rates.find{|r| r.service_code == "1D" }
    assert_equal "USPS", one_day.carrier
    assert_equal "USPS Express Mail", one_day.service_name
    assert_equal 2525, one_day.total_price
    assert_equal date + 1, one_day.delivery_date
    assert_equal [date + 1, date + 1], one_day.delivery_range
  end
  
  def test_gracefully_handle_new_carrier
    @carrier.expects(:ssl_post).returns(xml_fixture('shipwire/new_carrier_rate_response'))
    
    response = @carrier.find_rates(
                 @locations[:ottawa],
                 @locations[:beverly_hills],
                 @packages.values_at(:book, :wii),
                 :order_id => '#1000',
                 :items => @items
               )
    assert response.success?    
    assert_equal 1, response.rates.size
    assert ground = response.rates.first
    assert_equal "FESCO", ground.carrier
  end
  
  def test_find_rates_requires_items_option
    assert_raises(ArgumentError) do
      @carrier.find_rates(
        @locations[:ottawa],
        @locations[:beverly_hills],
        @packages.values_at(:book, :wii)
      )
    end
  end
  
  def test_validate_credentials_with_valid_credentials
    @carrier.expects(:ssl_post).returns(xml_fixture('shipwire/no_rates_response'))
    assert @carrier.valid_credentials?
  end
  
  def test_validate_credentials_with_invalid_credentials
    @carrier.expects(:ssl_post).returns(xml_fixture('shipwire/invalid_credentials_response'))
    assert !@carrier.valid_credentials?
  end
  
  def test_rate_request_includes_address_name_if_provided
    name = CGI.escape("<Name><Full>Bob Bobsen</Full></Name>")
    @carrier.expects(:ssl_post).with(anything, includes(name)).returns(xml_fixture('shipwire/rates_response'))
    
    response = @carrier.find_rates(
                 @locations[:ottawa],
                 @locations[:new_york_with_name],
                 @packages.values_at(:book, :wii),
                 :order_id => '#1000',
                 :items => @items
               )

    assert response.success?
  end
  
  def test_rate_request_does_not_include_address_name_element_if_not_provided
    name = CGI.escape("<Name>")
    @carrier.expects(:ssl_post).with(anything, Not(regexp_matches(Regexp.new(name)))).returns(xml_fixture('shipwire/rates_response'))
    
    response = @carrier.find_rates(
                 @locations[:ottawa],
                 @locations[:new_york],
                 @packages.values_at(:book, :wii),
                 :order_id => '#1000',
                 :items => @items
               )

    assert response.success?
  end

  def test_rate_request_without_delivery_estimate
    @carrier.expects(:ssl_post).returns(xml_fixture('shipwire/rates_response_no_estimate'))
    response = @carrier.find_rates(
                 @locations[:ottawa],
                 @locations[:new_york],
                 @packages.values_at(:book, :wii),
                 :order_id => '#1000',
                 :items => @items
               )

    assert response.success?
    assert_equal [], response.rates[0].delivery_range
    assert_nil response.rates[0].delivery_date
  end
end
