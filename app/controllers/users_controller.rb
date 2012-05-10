class UsersController < ApplicationController
  before_filter :login_required, :only => [ :change_password, :index ]  
  ssl_required :new, :create, :reset_password, :change_password

  def index
  end

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      @cart = Cart.find_by_session_id(request.session_options[:id])
      if @cart
        @cart.user = @user
        @cart.save
      end
      redirect_back_or_default('/cart/show')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact us."
      render :action => 'new'
    end
  end

  def activate
    @user = User.find_by_activation_code(params[:activation_code])
    if @user 
      @user.activate!
      flash[:notice] = "You can now login to your account."
    else
      flash[:notice] = "We couldn't find that activation code. Perhaps your account is already activated? Try logging in."
    end 
    redirect_to login_path
  end

  def reset_password
    return unless request.post?
    @user = User.find_by_email(params[:email])
    if @user
      @user.reset_password!
      flash.now[:notice] = 'Your password has been reset. Please check your email for your new password.'
    else
      flash.now[:notice] = 'We could not find your email address. Please sign up if you have not already.'
    end
  end

  def change_password
    return unless request.post?
    if params[:user][:password].blank?
      flash.now[:notice] = 'Please do not enter a blank password.'
      return
    end
    current_user.password = params[:user][:password]
    current_user.password_confirmation = params[:user][:password_confirmation]
    if current_user.save
      flash.now[:notice] = 'Your password has been updated.'
    else
      flash.now[:error] = 'Please check the errors below.'
    end
  end
end
