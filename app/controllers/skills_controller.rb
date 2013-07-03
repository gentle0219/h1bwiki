class SkillsController < ApplicationController
	def index
		arg = params[:q];
		@skills = SkillList.where("name like ?", "%#{arg}%")
		respond_to do |format|
			format.html
			format.json{ render :json => @skills.map(&:attributes)}
		end
	end
end