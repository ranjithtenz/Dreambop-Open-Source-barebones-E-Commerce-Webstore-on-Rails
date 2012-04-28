class CartController < ApplicationController
  before_filter :get_cart

  def show
    @shipping_address = nil
    if current_user.nil?
      @shipping_address = ShippingAddress.find_by_session_id(request.session_options[:id])
    end
    @checkout = Checkout.new(current_user, request.session_options[:id], @shipping_address)
  end

  def update
    @cart_product = CartProduct.new(:cart => @cart, :product_id => params[:id])
    @cart_product.save
    @cart = @cart.reload
    @cart_products = @cart.cart_products
    Cache.put 'cart_' + @cart.id.to_s, @cart_products
    #Cache.put 'user_' + current_user.id.to_s + '_cart', @cart
    redirect_to :action => :show
  end

  def delete
    cp = CartProduct.find(params[:id])
    if cp.cart == @cart
      cp.destroy
    end
    @cart.reload
    @cart_products = @cart.cart_products
    #Cache.put 'user_' + current_user.id.to_s + '_cart', @cart
    Cache.put 'cart_' + @cart.id.to_s, @cart_products
    redirect_to :action => :show
  end

protected
  def get_cart
    #@cart = Cache.get 'user_' + current_user.id.to_s + '_cart'
    unless @cart
      if current_user.nil?
        @cart = Cart.find_by_session_id(request.session_options[:id])
        unless @cart
          @cart = Cart.new(:user_id => 0, :session_id => request.session_options[:id])
          @cart.save
        end
      else
        @cart = current_user.cart
        if @cart.nil?
          @cart = Cart.new(:user => current_user)
          @cart.save
        end
      end
      #Cache.put 'user_' + current_user.id.to_s + '_cart', @cart
    end
    @cart_products = Cache.get 'cart_' + @cart.id.to_s
    unless @cart_products
      @cart_products = @cart.cart_products
      Cache.put 'cart_' + @cart.id.to_s, @cart_products
    end
  end

end
