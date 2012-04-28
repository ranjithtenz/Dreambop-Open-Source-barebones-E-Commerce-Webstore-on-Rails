class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.deliver_confirm_signup(user) 
  end


end
