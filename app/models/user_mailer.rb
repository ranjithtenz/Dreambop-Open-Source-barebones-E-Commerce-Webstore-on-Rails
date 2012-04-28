class UserMailer < ActionMailer::Base
  def confirm_signup(user)
     recipients user.email
     from       "support@yourdomain.com"
     subject    "Confirm your email address at mydomain"
     body       :user => user
   end

  def new_password(user)
     recipients user.email
     from       "support@yourdomain.com"
     subject    "Your new password"
     body       :user => user
   end
end
