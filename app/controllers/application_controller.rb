require 'authenticated_system.rb'
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include SslRequirement
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  #before_filter :dreambop
  #def dreambop
  #  if request.url.include? 'buymeyo.com'
  #    redirect_to request.url.gsub('buymeyo.com', 'dreambop.com')
  #  end
  #end
  def admin_login_required
    if current_user
      if current_user.has_role?('admin')
        return true
      end
    end
    flash[:notice] = "You must be an admin to view this section."
    redirect_to new_session_path and return false
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
