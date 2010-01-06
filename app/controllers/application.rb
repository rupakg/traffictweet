# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  #model :user

  #session :session_key => '_twitter_session_id'
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => '3530488f87fd804a9e7cbfa5b9936134'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
protected
  def authorize
     puts "#######"
puts session[:user_id]
puts User.find_by_id(session[:user_id])

    if User.find_by_id(session[:user_id])
puts "rizwana"
puts session[:user_id]
puts User.find_by_id(session[:user_id])
         flash[:notice] = "Please log in"
      redirect_to :controller => :twitt, :action => :login
    end
  end

end
