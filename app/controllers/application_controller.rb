require 'lib/authenticated_system.rb'
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  include SslRequirement
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :dreambop
  def dreambop
    if request.url.include? 'buymeyo.com'
      redirect_to request.url.gsub('buymeyo.com', 'dreambop.com')
    end
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
