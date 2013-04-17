class SearchEmployerController < ApplicationController
	autocomplete :h1bemp, :name, :full => true

  def h1bemployer  	
  	search_name = params[:h1bemp_name]
  	@search_h1bemp = H1bemp.find_by_name(search_name) if search_name.present?
  	@h1bemp_names = H1bemp.all.map { |e| e.name }
    if @search_h1bemp.present?
      @chart_img = Gchart.line( :size => '600x250',
#                              :theme => :keynote,
  														:title => 'H-1B and Green cards Statistics',
                              :legend => ['gc label','h1b label'],
                              :axis_with_labels => ['x', 'y'], 
                              :axis_labels => [['2010', '2011', '2012', '2013']], 
#                              :axis_range => [nil, [0,100,10]],
  														:data=>[[@search_h1bemp.gc2010.to_i,@search_h1bemp.gc2011.to_i,@search_h1bemp.gc2012.to_i,@search_h1bemp.gc2013.to_i],
  																		[@search_h1bemp.h1b2010.to_i,@search_h1bemp.h1b2011.to_i,@search_h1bemp.h1b2012.to_i, 0]
  												 					 ],
  														:line_colors => "FF0000,00FF00")    
    end
  end
  def search_names

  end
end
