class ShippingAddressesController < ApplicationController
  # GET /shipping_addresses
  # GET /shipping_addresses.xml
  before_filter :login_required, :except => [:new, :create]
  ssl_required :index, :show, :new, :edit, :create, :update , :destroy

  def index
    @shipping_addresses = Cache.get 'user_' + current_user.id.to_s + '_shippingaddresses'
    if @shipping_addresses.nil? or @shipping_addresses.empty?
      @shipping_addresses = current_user.shipping_addresses
      Cache.put 'user_' + current_user.id.to_s + '_shippingaddresses', @shipping_addresses
    end
    redirect_to :action => :new and return if @shipping_addresses.empty?
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shipping_addresses }
    end
  end

  # GET /shipping_addresses/1
  # GET /shipping_addresses/1.xml
  def show
    @shipping_address = Cache.get 'shipping_address_' + params[:id].to_s
    unless @shipping_address.empty?
      @shipping_address = ShippingAddress.find(params[:id])
      Cache.put 'shipping_address_' + params[:id].to_s, @shipping_address
    end
    redirect_to :controller => :sessions, :action => :new and return unless @shipping_address.user == current_user

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shipping_address }
    end
  end

  # GET /shipping_addresses/new
  # GET /shipping_addresses/new.xml
  def new
    @shipping_address = ShippingAddress.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shipping_address }
    end
  end

  # GET /shipping_addresses/1/edit
  def edit
    @shipping_address = ShippingAddress.find(params[:id])
    @shipping_address = Cache.get 'shipping_address_' + params[:id].to_s
    redirect_to :controller => :sessions, :action => :new and return unless @shipping_address.user == current_user
  end

  # POST /shipping_addresses
  # POST /shipping_addresses.xml
  def create
    if current_user.nil?
      @shipping_address = ShippingAddress.new(params[:shipping_address].merge(:user_id => 0, :session_id => request.session_options[:id] ))
    else
      @shipping_address = ShippingAddress.new(params[:shipping_address].merge(:user => current_user))
    end
    respond_to do |format|
      if @shipping_address.save
        #@shipping_addresses = current_user.shipping_addresses
        #Cache.put 'user_' + current_user.id.to_s + '_shippingaddresses', @shipping_addresses
        #if @shipping_addresses.size == 1 
        @shipping_address.set_default!
        if current_user.nil?
          format.html {redirect_to({:action => :show, :controller => :cart}, :notice => 'Shipping Address was successfully added.')}
        else
          format.html {redirect_to({:action => :new, :controller => :checkout}, :notice => 'Shipping Address was successfully added.')}
        end
        #end
        #format.html { redirect_to({:action => :index}, :notice => 'Shipping Address was successfully added.') }
        #format.xml  { render :xml => @shipping_address, :status => :created, :location => @shipping_address }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shipping_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shipping_addresses/1
  # PUT /shipping_addresses/1.xml
  def update
    @shipping_address = Cache.get 'shipping_address_' + params[:id].to_s
    unless @shipping_address.emtpy?
      @shipping_address = ShippingAddress.find(params[:id])
    end
    redirect_to :controller => :sessions, :action => :new and return unless @shipping_address.user == current_user

    respond_to do |format|
      if @shipping_address.update_attributes(params[:shipping_address])
        Cache.put 'shipping_address_' + params[:id].to_s, @shipping_address
        format.html { redirect_to( :action => :index, :notice => 'Shipping Address was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shipping_address.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shipping_addresses/1
  # DELETE /shipping_addresses/1.xml
  def destroy
    @shipping_address = ShippingAddress.find(params[:id])
    redirect_to :controller => :sessions, :action => :new and return unless @shipping_address.user == current_user
    @shipping_address.destroy
    @shipping_addresses = current_user.shipping_addresses
    Cache.put 'user_' + current_user.id.to_s + '_shippingaddresses', @shipping_addresses

    respond_to do |format|
      format.html { redirect_to(shipping_addresses_url) }
      format.xml  { head :ok }
    end
  end

end
