class ApplicationController < ActionController::Base
	protect_from_forgery	

	private
	def employer?			
		if !user_signed_in?
			redirect_to new_user_session_path
		else
			current_user.account_type == "employer" ? true : false		
		end
	end

	def require_login_employer
		if !user_signed_in?
			redirect_to new_user_session_path
		else
			if !employer?
				flash[:notice] = 'Sorry, Only an Employer can use this page'
				redirect_to root_url
			end	
		end	
	end
	def require_login_job_seeker
		if !user_signed_in?
			redirect_to new_user_session_path
		else
			if employer?
				flash[:notice] = 'Sorry, Only a Job Seeker can use this page'
				redirect_to root_url
			end	
		end 
	end
	def require_login!
		redirect_to new_user_session_path if !user_signed_in?		
	end
	helper_method :employer?
end
