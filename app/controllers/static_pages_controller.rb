class StaticPagesController < ApplicationController
  def home        
    if user_signed_in?
      if current_user.account_type == "employer"
        redirect_to :posts_view
      else
        redirect_to :search_home
      end
    end
  end

  def about
  end

  def help
  end

  def contact
  end

  def signup
  end
# For employer  
  def post_main    
  end
  def posts
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @post_jobs = current_user.post_jobs.paginate(:page => params[:job_page], :per_page => 10)
      @post_trainings = current_user.post_trainings.paginate(:page => params[:trining_page], :per_page => 10)
      @post_mentors = current_user.post_mentors.paginate(:page => params[:mentor_page], :per_page => 10)
    end
  end
# For Job Seeker
  def jobseeker_post_main
  end
  def jobseeker_posts
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @jobseeker_jobs = current_user.jobseeker_jobs.paginate(:page => params[:job_page], :per_page => 10)
      @jobseeker_trainings = current_user.jobseeker_trainings.paginate(:page => params[:trining_page], :per_page => 10)
      @jobseeker_mentors = current_user.jobseeker_mentors.paginate(:page => params[:mentor_page], :per_page => 10)
    end
  end
  def search_home    
    
    @search_emp_jobs, @search_seeker_jobs, @search_emp_trainings, @search_seeker_trainings, @search_emp_mentors, @search_seeker_mentors = [],[],[],[],[],[]

    @search_type = params[:search_type].blank? ? 0 : params[:search_type]
    @job_type = params[:type]
    cond_text, cond_values = [], []
    title = params[:title]
    city = params[:city]
    if @job_type == '1' or @job_type == '0'
      if title.present?
        cond_text << "(job_title LIKE ? OR job_description LIKE ?)"
        cond_values << "%#{title}%"
        cond_values << "%#{title}%"
      end
      if city.present?
        cond_text << "job_city = ?" 
        cond_values << "#{city}"
      end
    elsif @job_type =='2'
      if title.present?
        cond_text << "title LIKE ?"
        cond_values << "#{title}"
      end      
    end

=begin
    if params[:search_type].blank?
      @search_emp_jobs = PostJob.find(:all, :order=>"created_at DESC")
      @search_seeker_jobs = JobseekerJob.find(:all, :order=>"created_at DESC")
      
      @search_emp_trainings = PostTraining.find(:all, :order=>"created_at DESC")
      @search_seeker_trainings = JobseekerTraining.find(:all, :order=>"created_at DESC")
      
      @search_emp_mentors = PostMentor.find(:all, :order=>"created_at DESC")
      @search_seeker_mentors = JobseekerMentor.find(:all, :order=>"created_at DESC")
    end
=end
  
    if @search_type == '0'
      if @job_type == '1'
        @search_emp_jobs = PostJob.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        #@search_emp_jobs = PostJob.find(:all, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        @search_seeker_jobs = []
#render :text => @search_emp_jobs.inspect and return
      elsif @job_type == '2'
        if city.present?
          city = "%" + city + "%"
          @search_seeker_jobs=[]
          User.find(:all, :conditions => ["city LIKE ?", city]).each do |user|
            @search_seeker_jobs += user.jobseeker_jobs.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
          end
        else
          @search_seeker_jobs = JobseekerJob.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        end        
        @search_emp_jobs = []
      else
        #render :text=>[cond_text.join(" AND "), *cond_values].inspect and return
        @search_emp_jobs = PostJob.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        @search_seeker_jobs = JobseekerJob.search(params[:title], params[:city])
      end
    elsif @search_type == '1'
      if @job_type == '1'
        @search_emp_trainings = PostTraining.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        @search_seeker_trainings = []
      elsif @job_type == '2'
        @search_seeker_trainings = JobseekerJob.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        @search_emp_trainings = []
      else
        @search_emp_trainings = PostTraining.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        @search_seeker_trainings = JobseekerJob.search(params[:title], params[:city])
      end
    elsif @search_type == '2'
      if @job_type == '1'
        @search_emp_mentors = PostMentor.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        @search_seeker_mentors = []
      elsif @job_type == '2'
        @search_seeker_mentors = JobseekerMentor.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        @search_emp_mentors = []
      else
        @search_emp_mentors = PostMentor.paginate(:page => params[:page_num], :per_page => 5, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        @search_seeker_mentors = JobseekerMentor.paginate(:page => params[:page_num], :per_page => 5, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
      end
    end
  end  

  
  def account_setup
    redirect_to root_url and return unless current_user.present?
    @company = current_user.company.present? ? current_user.company : current_user.build_company
    @contact = current_user.contact.present? ? current_user.contact : current_user.build_contact
  end

  def update_profile
    redirect_to root_url and return unless current_user.present?
    
    if current_user.company.present?
      @company = current_user.company
      @company.update_attributes(params[:company])
    else
      @company = current_user.build_company params[:company]
    end
    @company.save
    if current_user.contact.present?
      @contact = current_user.contact
      @contact.update_attributes(params[:contact])
    else
      @contact = current_user.build_contact params[:contact]
    end
    @contact.save
    #render :text=>@company.inspect and return
    redirect_to '/account_details' and return
  end

  def account_details
    redirect_to root_url and return unless current_user.present?
    @company = current_user.company
    @contact = current_user.contact
  end

  def change_passwd
    redirect_to root_url and return unless current_user.present?
  end
  
  def reset_passwd
    redirect_to root_url and return unless current_user.present?
    user = User.find(current_user.id)
=begin    
    if user.password == params[:cur_pass]
      current_user.password=params[:new_pass]
      current_user.password_confirmation=params[:conf_pass]
      current_user.save
      flash[:notice] = "Your password was changed successfuly"
      redirect_to root_url and return
    else
      flash[:notice] = "Please check current password"
      redirect_to :back and return
    end
=end      
  end
end
