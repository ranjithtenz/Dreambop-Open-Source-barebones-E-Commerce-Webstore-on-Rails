class CheckoutController < ApplicationController
  before_filter :login_required
  ssl_required :new, :select_address

  def select_address
    if params[:shipping_address].nil? or params[:shipping_address][:id].nil? or params[:shipping_address][:id].empty? 
      flash[:notice] = 'Please select a shipping address to ship to.'
      redirect_to :controller => :shipping_addresses, :action => :index
      return
    end
    @shipping_address = ShippingAddress.find(params[:shipping_address][:id])
    @shipping_address.set_default!
    redirect_to :action => :new
  end

  def new
    redirect_to '/session/new' and return if current_user.nil? 
    redirect_to '/shipping_addresses/new' and return if current_user.shipping_address.nil? 
    redirect_to '/credit_cards/decision_prompt' and return if session[:payment_method].blank? 
    redirect_to '/credit_cards/new' and return if session[:payment_method] == 'card' and current_user.credit_card.nil?
    redirect_to '/credit_cards/edit' and return if session[:payment_method] == 'card' and not current_user.credit_card.has_billing_details?
    @cart = current_user.cart
    @products = @cart.products
    @shipping_address = current_user.shipping_address
    @credit_card = current_user.credit_card
    @checkout = Checkout.new(current_user)
  end

end
