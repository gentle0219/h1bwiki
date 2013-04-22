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
			@top_avg_data = @search_h1bemp.get_top_job_data("TopAvg")
=begin
			h1b_c_data = @search_h1bemp.get_filing_data('H1B', 'CERTIFIED')
			h1b_cw_data = @search_h1bemp.get_filing_data('H1B', 'CERTIFIED-WITHDRAWN')
			h1b_d_data = @search_h1bemp.get_filing_data('H1B', 'DENIED')
			h1b_w_data = @search_h1bemp.get_filing_data('H1B', 'WITHDRAWN')
			@h1b_chart_img = Gchart.bar( :size => '600x150',
#															:theme => :keynote,
															:title => 'H-1B Statistics',
															:legend => ["CERTIFIED", "CERTIFIED-WITHDRAWN", "DENIED", "WITHDRAWN" ],
															:axis_with_labels => ['y'], 
															:axis_labels => [['2010', '2011', '2012', '2013']], 
#															:axis_range => [nil, [0,100,10]],
															:data=>[h1b_c_data, h1b_cw_data, h1b_d_data, h1b_w_data],
															:orientation => 'horizontal',
															:line_colors => "FF0000,00FF00,FAA732,4D90FE")

			gc_c_data = @search_h1bemp.get_filing_data('GC', 'CERTIFIED')
			gc_cw_data = @search_h1bemp.get_filing_data('GC', 'CERTIFIED-WITHDRAWN')
			gc_d_data = @search_h1bemp.get_filing_data('GC', 'DENIED')
			gc_w_data = @search_h1bemp.get_filing_data('GC', 'WITHDRAWN')
			@gc_chart_img = Gchart.bar( :size => '600x150',
#															:theme => :keynote,
															:title => 'Green cards Statistics',
															:legend => ["CERTIFIED", "CERTIFIED-WITHDRAWN", "DENIED", "WITHDRAWN" ],
															:axis_with_labels => ['y'], 
															:axis_labels => [['2010', '2011', '2012', '2013']], 
#															:axis_range => [nil, [0,100,10]],
															:data=>[gc_c_data, gc_cw_data, gc_d_data, gc_w_data],															
															:orientation => 'horizontal',
															:line_colors => "FF0000,00FF00,FAA732,4D90FE")
=end															
		end
	end
	def search_names

	end
end
