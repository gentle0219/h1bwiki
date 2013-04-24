class SearchEmployerController < ApplicationController
	autocomplete :h1bemp, :name, :full => true

	def h1bemployer		
		@h1b_chart_data = @gc_chart_data = @top_hired_data = @top_avg_data = 0
		search_name = params[:h1bemp_name]
		@search_h1bemp = H1bemp.find_by_employerName(search_name) if search_name.present?
		@h1bemp_names = H1bemp.all.map { |e| e.employerName }		
		if @search_h1bemp.present?
			@h1b_chart_data = @search_h1bemp.get_data("H1B")
			@gc_chart_data = @search_h1bemp.get_data("GC")

			@top_hired_data = @search_h1bemp.get_top_job_data("TopHired")
			@top_hired_table_data = @search_h1bemp.get_top_job_table_data("TopHired")

			@top_avg_data = @search_h1bemp.get_top_job_data("TopAvg")
			@top_avg_table_data = @search_h1bemp.get_top_job_table_data("TopAvg")

			@comments = @search_h1bemp.root_comments
		end
	end
	def rate
		@search_h1bemp = H1bemp.find(params[:id])
		@search_h1bemp.rate(params[:stars], current_user, params[:dimension])		
		average = @search_h1bemp.rate_average(true, params[:dimension])
		width = (average/@search_h1bemp.class.max_stars.to_f)*100
		render :json => {:id => @search_h1bemp.wrapper_dom_id(params), :width => width}	
		#render :update do |page|
		#	page.replace_html @search_h1bemp.wrapper_dom_id(params), ratings_for(@search_h1bemp, params.merge(:wrap => false))
		#	page.visual_effect :highlight, @search_h1bemp.wrapper_dom_id(params)
		#end
	end
	def add_comment
		search_h1bemp = H1bemp.find(params[:id])
		user_who_commented_id = current_user.id
		comment = Comment.build_from( search_h1bemp, user_who_commented_id, params[:content])
		comment.subject = current_user.user_name+ " to " + search_h1bemp.employerName
		comment.save
		@comments = search_h1bemp.root_comments
		
		respond_to do |format|
      format.js {
        @return_content = render_to_string(:partial => "comments")
        @return_content
      }
    end

	end
end
