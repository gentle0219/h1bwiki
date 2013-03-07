class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def help
  end

  def contact
  end

  def signup
  end
  def post_main    
  end
  def posts
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @post_jobs = current_user.post_jobs.paginate(:page => params[:job_page], :per_page => 15)
      @post_trainings = current_user.post_trainings.paginate(:page => params[:trining_page], :per_page => 15)
      @post_mentors = current_user.post_mentors.paginate(:page => params[:mentor_page], :per_page => 15)
    end
  end
end
