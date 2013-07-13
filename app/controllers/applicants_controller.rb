class ApplicantsController < ApplicationController
	before_filter :authenticate_user!
  def create  	
  	@applicant = Applicant.new params[:applicant]
    session[:return_to] ||= request.referer 
  	if @applicant.save
  		recipient = @applicant.post_job.user
	    current_user.send_message(recipient, @applicant.bid_sentence, @applicant.post_job.job_title )
	    #current_user.send_message(recipients, *conversation_params(:body, :subject)).conversation	    
      flash[:notice] = "Success"
      redirect_to session[:return_to]
    else
      flash[:notice] = "Please select the .pdf, doc, docx"
      redirect_to session[:return_to]
  	end
    
  end

  def destroy
  end
  
end
