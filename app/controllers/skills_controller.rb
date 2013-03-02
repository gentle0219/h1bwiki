class SkillsController < ApplicationController
	def index
		@skills = SkillList.where("name like ?", "%#{params[:q]}%")
		respond_to do |format|
			format.html
			format.json{ render :json => @skills.map(&:attributes)}
		end
	end
end