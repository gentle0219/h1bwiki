class UserMailer < ActionMailer::Base
	default :from => "admin@luxesocialevents.com"
  
  def welcome_email(user)
    mail(:to => user.email, :subject => "Invitation Request Received")
  end

  def contact(name, receive_mail, phone)
    admin = User::get_admin()
    admin_email = admin.mail    
  	@data = { :name => name, :email=>receive_mail, :phone => phone}
  	mail(:to => admin_email, :subject => name)
    mail(:to => 'adisin8@gmail.com', :subject => name)
  end

  def forward(from_email, to_email, name, subject, post_job_id)
    email_with_name = "#{name} < #{to_email}"
    @post_job = PostJob.find_by_id(post_job_id)
  	mail(:to => email_with_name, :subject => subject)  	
  end
  
end