class RegistrationsController < Devise::RegistrationsController	
	def new_jobseeker
		new
		session[:account_type] = 'jobseeker'
	end
	def new_employer
		new
		session[:account_type] = 'employer'
	end
	def create
		if session[:account_type] == "jobseeker"
			if verify_recaptcha
				super
			else
				build_resource
	      clean_up_passwords(resource)
	      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
	      flash.delete :recaptcha_error
	      render :new
			end		
		else
			super
		end
	end
end
