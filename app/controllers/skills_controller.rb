class SkillsController < ApplicationController
	def index
		arg = params[:q];
		@skills = SkillList.where("lower(name) like lower(?)", "%#{arg}%")
		respond_to do |format|
			format.html
			format.json{ render :json => @skills.map(&:attributes)}
		end
	end
end