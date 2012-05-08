class OrdersController < ApplicationController
  before_filter :login_required
  ssl_required :index, :show, :new, :create, :paypal
  # GET /orders
  # GET /orders.xml
  def paypal
    @checkout = Checkout.new(current_user)
    setup_response = gateway.setup_purchase(@checkout.total * 100,
      :ip                => request.remote_ip,
      :return_url        => paypal_complete_orders_url,
      :cancel_return_url => url_for(:action => :new, :controller => :checkout)
    )
    redirect_to gateway.redirect_url_for(setup_response.token)
  end


  def paypal_complete
    details_response = gateway.details_for(params[:token])
    if !details_response.success?
      flash[:notice] = details_response.message
      redirect_to :action => :new, :controller => :checkout
      return
    end
    @checkout = Checkout.new(current_user)
    purchase = gateway.purchase(@checkout.total * 100,
      :ip       => request.remote_ip,
      :payer_id => params[:PayerID],
      :token    => params[:token]
    )
    
    if !purchase.success?
      flash[:notice] = purchase.message
      redirect_to :action => :new, :controller => :checkout
      return
    end

    #@address = details_response.address
    @order = Order.new(:user => current_user, :paypal_details => { :authorization_id => purchase.authorization, :address => details_response.params })
    @order.save
    session[:payment_method] = nil
    @cart = current_user.cart
    Cache.put 'user_' + current_user.id.to_s + '_cart', @cart
    @cart_products = @cart.cart_products
    Cache.put 'cart_' + @cart.id.to_s, @cart_products
    respond_to do |format|
      format.html { redirect_to(@order, :notice => 'Order was successfully processed.') }
      format.xml  { render :xml => @order, :status => :created, :location => @order }
    end
  end

  def index
    @orders = Cache.get 'user_' + current_user.id.to_s + '_orders'
    unless @orders
      @orders = current_user.orders
      Cache.put 'user_' + current_user.id.to_s + '_orders', @orders
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.xml
  def show
    @order = Cache.get 'order_' + params[:id].to_s
    unless @order
      @order = Order.find(params[:id])
      Cache.put 'order_' + params[:id].to_s, @order
    end
    redirect_to :controller => :sessions, :action => :new and return unless @order.user == current_user
    @products = Cache.get 'order_' + @order.id.to_s + '_products'
    unless @products
      @products = @order.products
      Cache.put 'order_' + @order.id.to_s + '_products', @products
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end

  # GET /orders/1/edit
=begin
  def edit
    @order = Order.find(params[:id])
    redirect_to :controller => :sessions, :action => :new and return unless @order.user == current_user
  end
=end

  # POST /orders
  # POST /orders.xml
  def create
    @order = Order.new(:user => current_user)
    respond_to do |format|
      if @order.save
        session[:payment_method] = nil
        @cart = current_user.cart
        Cache.put 'user_' + current_user.id.to_s + '_cart', @cart
        @cart_products = @cart.cart_products
        Cache.put 'cart_' + @cart.id.to_s, @cart_products
        format.html { redirect_to(@order, :notice => 'Order was successfully processed.') }
        format.xml  { render :xml => @order, :status => :created, :location => @order }
      else
        format.html { flash[:notice] = "Sorry, we experienced a problem. Please try again." 
                      redirect_to(:controller => :checkout, :action => "new") }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.xml
=begin
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to(@order, :notice => 'Order was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.xml
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end
=end
private
  def gateway
    if Rails.env.test? == 'test' or Rails.env.development? == 'development'
      ActiveMerchant::Billing::Base.mode = :test
      @gateway ||= ActiveMerchant::Billing::PaypalExpressGateway.new(
        :login => "thedude.yourdomain.com",
        :password => "whiterussian",
        :signature => "thedudeabides"
      )
    else
      ActiveMerchant::Billing::Base.mode = :production
      @gateway ||= ActiveMerchant::Billing::PaypalExpressGateway.new(
        :login => "thedude.yourdomain.com",
        :password => "whiterussian",
        :signature => "thedudeabides"
      )
    end
  end
end
