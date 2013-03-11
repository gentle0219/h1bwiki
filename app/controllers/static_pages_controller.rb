class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      redirect_to search_home_path
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
    if @job_type == '1'
      if title.present?
        cond_text << "job_title LIKE ?"
        cond_values << "%#{title}%"
      end
      if city.present?
        cond_text << "job_city LIKE ?"
        cond_values << "%#{city}%"
      end
    elsif @job_type =='2'
      if title.present?
        cond_text << "title LIKE ?"
        cond_values << "%#{title}%"
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
        @search_seeker_jobs = []
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
        @search_emp_jobs = PostJob.search(params[:title], params[:city])
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
        @search_emp_trainings = PostTraining.find(:all, :order=>"created_at DESC")
        @search_seeker_trainings = JobseekerJob.search(params[:title], params[:city])
      end
    elsif @search_type == '2'
      if @job_type == '1'
        @search_emp_mentors = PostMentor.paginate(:page => params[:page_num], :per_page => 1, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        @search_seeker_mentors = []
      elsif @job_type == '2'
        @search_seeker_mentors = JobseekerMentor.paginate(:page => params[:page_num], :per_page => 1, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        @search_emp_mentors = []
      else
        @search_emp_mentors = PostMentor.search(params[:title])
        @search_seeker_mentors = JobseekerMentor.search(params[:title])
      end
    end
  end  
end
