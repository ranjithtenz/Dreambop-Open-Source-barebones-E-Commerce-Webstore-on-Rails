class CreditCardsController < ApplicationController
  before_filter :login_required, :except => [:decision, :new, :create]
  ssl_required :show, :new, :edit, :create, :update 

  # GET /credit_cards/1
  # GET /credit_cards/1.xml
  def show
    @credit_card = Cache.get 'user_' + current_user.id.to_s + '_creditcard'
    unless @credit_card
      @credit_card = current_user.credit_card
      Cache.put 'user_' + current_user.id.to_s + '_creditcard', @credit_card
    end
    redirect_to :action => :edit and return unless @credit_card.valid? 
    @cart = current_user.cart
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @credit_card }
    end
  end

  def decision_prompt
  end

  def decision
    @method = params[:payment_method]
    if @method.nil?
      flash[:notice] = "Please select a payment method"
      redirect_to :action => :decision_prompt and return
    end
    if @method[:id] == 'paypal'
      session[:payment_method] = 'paypal'
      if current_user.shipping_address
        redirect_to :controller => :checkout, :action => :new
      else
        redirect_to :controller => :shipping_addresses, :action => :new
      end
    elsif @method[:id] == 'card'
      session[:payment_method] = 'card'
      if current_user.nil? or current_user.credit_card.nil?
        redirect_to :action => :new
      else
        redirect_to :controller => :checkout, :action => :new
      end
    end
  end
  # GET /credit_cards/new
  # GET /credit_cards/new.xml
  def new
    if current_user.nil?
      @user = User.new
    end
    @credit_card = CreditCard.new(:month => Date.today.month, :year => Date.today.year)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @credit_card }
    end
  end

  # GET /credit_cards/1/edit
  def edit
    @credit_card = current_user.credit_card 
    @cart = current_user.cart
  end

  # POST /credit_cards
  # POST /credit_cards.xml
  def create
    if current_user.nil?
      @user = User.new(params[:user].merge(:password_confirmation => params[:user][:password]))
      if @user.save
        #set current cart and shipping to this new user
        user = User.authenticate(params[:user][:email], params[:user][:password])
        self.current_user = user 
        new_cookie_flag = true #old (params[:remember_me] == "1")
        #handle_remember_cookie! new_cookie_flag
        shipping_address = ShippingAddress.find_by_session_id(request.session_options[:id])
        cart = Cart.find_by_session_id(request.session_options[:id])
        cart.user = current_user
        cart.save
        shipping_address.user = current_user
        shipping_address.save
      else
        @credit_card = CreditCard.new(params[:credit_card])
        render :new
        return
      end
    end
    @credit_card = CreditCard.new(params[:credit_card])
    @credit_card.user = current_user

    respond_to do |format|
      if @credit_card.save
        Cache.put 'user_' + current_user.id.to_s + '_creditcard', @credit_card
        format.html { redirect_to({:action => :new, :controller => :checkout}, :notice => 'Credit card info successfully saved.') }
        format.xml  { render :xml => @credit_card, :status => :created, :location => @credit_card }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @credit_card.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /credit_cards/1
  # PUT /credit_cards/1.xml
  def update
    @credit_card = Cache.get 'user_' + current_user.id.to_s + '_creditcard'
    unless @credit_card
      @credit_card = current_user.credit_card
    end

    respond_to do |format|
      if @credit_card.update_attributes(params[:credit_card].merge(params[:date]))
        Cache.put 'user_' + current_user.id.to_s + '_creditcard', @credit_card.reload
        format.html { redirect_to({:action => :new, :controller => :checkout}, :notice => 'Your credit card was successfully updated.') }
        format.xml  { head :ok }
      else
      	@cart = current_user.cart
        format.html { render :action => "edit" }
        format.xml  { render :xml => @credit_card.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_cards/1
  # DELETE /credit_cards/1.xml
=begin
  def destroy
    @credit_card = CreditCard.find(params[:id])
    @credit_card.destroy

    respond_to do |format|
      format.html { redirect_to(credit_cards_url) }
      format.xml  { head :ok }
    end
  end
=end
end
