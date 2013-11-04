class UserMailer < ActionMailer::Base
	default :from => "admin@h1bwiki.com"
  
  def welcome_email(user)
    mail(:to => user.email, :subject => "Invitation Request Received")
  end

  def contact(name, receive_mail, phone)
    admin = User::get_admin()
    admin_email = admin.mail    
  	@data = { :name => name, :email=>receive_mail, :phone => phone}
  	mail(:to => admin_email, :subject => name)
    mail(:to => 'admin@h1bwiki.com', :subject => name)
  end

  def forward(from_email, to_email, name, post_job_id)
    email_with_name = "#{name} < #{to_email}"
    @post_job = PostJob.find_by_id(post_job_id)
    @name = name
    @url = "http://h1bwiki.herokuapp.com#{post_job_path(@post_job)}"
  	mail(:to => email_with_name, :subject => @post_job.job_title)  	
  end
  
  def created(user)
    @user=user
    mail(:to => @user.email, :subject => "Your account is awaiting for admin approval")
    UserMailer.send_to_admin(@user).deliver
  end
  def send_to_admin(user)
    mail(:to => 'admin@h1bwiki.com', :subject => "A new employer is awaiting for admin approval")    
  end
  def approved(user)
    @user=user
    mail(:to => @user.email, :subject => "Your account has been approved")
  end
end