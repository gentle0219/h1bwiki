class PostTrainingsController < ApplicationController  
  before_filter :require_login_job

  # GET /post_trainings
  # GET /post_trainings.json
  def index
    @post_trainings = current_user.post_trainings.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @post_trainings }
    end
  end

  # GET /post_trainings/1
  # GET /post_trainings/1.json
  def show
    @post_training = PostTraining.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post_training }
    end
  end

  # GET /post_trainings/new
  # GET /post_trainings/new.json
  def new
    @post_training = PostTraining.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post_training }
    end
  end

  # GET /post_trainings/1/edit
  def edit
    @post_training = PostTraining.find(params[:id])
  end

  # POST /post_trainings
  # POST /post_trainings.json
  def create
    @post_training = PostTraining.new(params[:post_training])

    respond_to do |format|
      if @post_training.save
        format.html { redirect_to posts_view_path, notice: 'Success! Your Training/Placement Posting is Created' }
        format.json { render json: @post_training, status: :created, location: @post_training }
      else
        format.html { render action: "new" }
        format.json { render json: @post_training.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /post_trainings/1
  # PUT /post_trainings/1.json
  def update
    @post_training = PostTraining.find(params[:id])

    respond_to do |format|
      if @post_training.update_attributes(params[:post_training])
        format.html { redirect_to posts_view_path, notice: 'Success! Your Training/Placement Posting is updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post_training.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_trainings/1
  # DELETE /post_trainings/1.json
  def destroy
    @post_training = PostTraining.find(params[:id])
    @post_training.destroy

    respond_to do |format|
      format.html { redirect_to posts_view_path }
      format.json { head :no_content }
    end
  end
end
