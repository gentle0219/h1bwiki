class ApplicantsController < ApplicationController
  def create  	
  	@applicant = Applicant.new params[:applicant]  	
  	if @applicant.save
  		recipient = @applicant.post_job.user
	    current_user.send_message(recipient, @applicant.bid_sentence, @applicant.post_job.job_title )
	    #current_user.send_message(recipients, *conversation_params(:body, :subject)).conversation
	    session[:return_to] ||= request.referer
	    redirect_to session[:return_to]
  	end
  end

  def destroy
  end
  
end
