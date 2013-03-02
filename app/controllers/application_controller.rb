class ApplicationController < ActionController::Base
  protect_from_forgery  

  def employer?  		
  	current_user.account_type == "employer" ? true : false  	
  end

  def require_login_job
  	if !user_signed_in?
  		redirect_to new_user_session_path
  	else
  		if !employer?
	  		flash[:notice] = 'Sorry, Only an employer can use this page'
	  		redirect_to root_url
  		end  
  	end	
  end
end
