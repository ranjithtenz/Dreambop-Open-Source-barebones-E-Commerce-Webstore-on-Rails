require 'test_helper'

class NewZealandPostTest < Test::Unit::TestCase

  def setup
    @packages  = TestFixtures.packages
    @locations = TestFixtures.locations
    @carrier   = NewZealandPost.new(fixtures(:new_zealand_post).merge(:test => true))
    @wellington = @locations[:wellington]
    @auckland = @locations[:auckland]
    @ottawa = @locations[:ottawa]
  end

  def test_valid_credentials
    assert @carrier.valid_credentials?
  end

  def test_domestic_response
    response = @carrier.find_rates(@wellington, @auckland, @packages[:wii])

    assert response.is_a?(RateResponse)
    assert response.success?
    assert response.rates.any?
    assert response.rates.first.is_a?(RateEstimate)
    assert_equal 1, response.params["responses"].size
    assert_equal 1, response.request.size
    assert_equal 1, response.raw_responses.size
    assert response.request.first.size > 0
    assert response.params["responses"].first.size > 0
    assert response.raw_responses.first.size > 0
  end

  def test_domestic_combined_response
    response = @carrier.find_rates(@wellington, @auckland, @packages.values_at(:book, :small_half_pound))

    assert response.is_a?(RateResponse)
    assert response.success?
    assert response.rates.any?
    assert response.rates.first.is_a?(RateEstimate)
    assert_equal 2, response.params["responses"].size
    assert_equal 2, response.request.size
    assert_equal 2, response.raw_responses.size
    assert response.request.first.size > 0
    assert response.params["responses"].first.size > 0
    assert response.raw_responses.first.size > 0
  end

  def test_domestic_failed_response_raises
    assert_raises ActiveMerchant::Shipping::ResponseError do
      @carrier.find_rates(@wellington, @auckland, @packages[:shipping_container])
    end
  end

  def test_domestic_failed_response_message
    error = @carrier.find_rates(@wellington, @auckland, @packages[:shipping_container]) rescue $!
    assert_match /Length can only be between 0 and 150cm/, error.message
  end

  def test_domestic_combined_response_prices
    response_book = @carrier.find_rates(@wellington, @auckland, @packages[:book])
    response_small_half_pound = @carrier.find_rates(@wellington, @auckland, @packages[:small_half_pound])
    response_combined = @carrier.find_rates(@wellington, @auckland, @packages.values_at(:book, :small_half_pound))

    assert response_combined.is_a?(RateResponse)
    assert response_combined.success?
    assert response_book.rates.first.is_a?(RateEstimate)
    assert response_small_half_pound.rates.first.is_a?(RateEstimate)
    assert response_combined.rates.first.is_a?(RateEstimate)

    sum_book_prices = response_book.rates.sum { |rate| rate.price }
    sum_small_half_pound_prices = response_small_half_pound.rates.sum { |rate| rate.price }
    sum_combined_prices = response_combined.rates.sum { |rate| rate.price }

    assert sum_book_prices > 0
    assert sum_small_half_pound_prices > 0
    assert sum_combined_prices > 0
    assert sum_combined_prices <= sum_book_prices + sum_small_half_pound_prices

    # uncomment this test for visual display of combining rates
    # puts "\nBook:"
    # response_wii.rate_estimates.each{ |r| puts "\nTotal Price: #{r.total_price}\nService Name: #{r.service_name} (#{r.service_code})" }
    # puts "\Small half pound:"
    # response_book.rate_estimates.each{ |r| puts "\nTotal Price: #{r.total_price}\nService Name: #{r.service_name} (#{r.service_code})" }
    # puts "\nCombined"
    # response_combined.rate_estimates.each{ |r| puts "\nTotal Price: #{r.total_price}\nService Name: #{r.service_name} (#{r.service_code})" }
  end

  def test_international_book_response
    response = @carrier.find_rates(@wellington, @ottawa, @packages[:book])
    assert response.is_a?(RateResponse)
    assert response.success?
    assert response.rates.any?
    assert response.rates.first.is_a?(RateEstimate)
  end

  def test_international_poster_response
    response = @carrier.find_rates(@wellington, @ottawa, @packages[:poster])
    assert response.is_a?(RateResponse)
    assert response.success?
    assert response.rates.any?
    assert response.rates.first.is_a?(RateEstimate)
  end

  def test_international_combined_response
    response = @carrier.find_rates(@wellington, @ottawa, @packages.values_at(:book, :poster))
    assert response.is_a?(RateResponse)
    assert response.success?
    assert response.rates.any?
    assert response.rates.first.is_a?(RateEstimate)
    assert_equal 2, response.params["responses"].size
    assert_equal 2, response.request.size
    assert_equal 2, response.raw_responses.size
    assert response.request.first.size > 0
    assert response.params["responses"].first.size > 0
    assert response.raw_responses.first.size > 0
  end

  def test_international_shipping_container_response
    response = @carrier.find_rates(@wellington, @ottawa, @packages[:shipping_container])
    assert response.is_a?(RateResponse)
    assert response.success?
    assert_equal 0, response.rates.size
  end

  def test_international_gold_bar_response
    response = @carrier.find_rates(@wellington, @ottawa, @packages[:largest_gold_bar])
    assert response.is_a?(RateResponse)
    assert response.success?
    assert_equal 0, response.rates.size
  end

  def test_international_empty_package_response
    response = @carrier.find_rates(@wellington, @ottawa, @packages[:just_zero_weight])
    assert response.is_a?(RateResponse)
    assert response.success?
    assert_equal 0, response.rates.size
  end

  def test_international_just_country_given
    response = @carrier.find_rates(@wellington, Location.new(:country => 'CZ'), @packages[:book])
    assert response.is_a?(RateResponse)
    assert response.success?
    assert response.rates.size > 0
  end

end
