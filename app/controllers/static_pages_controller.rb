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
      @post_jobs = current_user.post_jobs.all
      @post_trainings = current_user.post_trainings.all
      @post_mentors = current_user.post_mentors.all
    end
  end
end
