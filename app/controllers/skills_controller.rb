class SkillsController < ApplicationController
	def index
		arg = params[:q].downcase.to_s;
		@skills = SkillList.where("name like ?", "%#{arg}%")
		respond_to do |format|
			format.html
			format.json{ render :json => @skills.map(&:attributes)}
		end
	end
end