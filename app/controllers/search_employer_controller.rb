class SearchEmployerController < ApplicationController
	autocomplete :h1bemp, :name, :full => true

  def h1bemployer  	
  	search_name = params[:h1bemp_name]
  	@search_h1bemp = H1bemp.find_by_name(search_name) if search_name.present?
  	@h1bemp_names = H1bemp.all.map { |e| e.name }
  end
  def search_names

  end
end
