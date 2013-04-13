class SearchEmployerController < ApplicationController
  def h1bemployer  	
  	search_name = params[:h1bemp_name]
  	@search_h1bemp = H1bemp.find_by_name( search_name) if search_name.present?
  end
  def search_h1bemployer

  end
end
