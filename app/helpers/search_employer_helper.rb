module SearchEmployerHelper
	def overview_item val
		val = val.downcase
		return raw("<div class='res-box val-green'><p>#{val.upcase}</p></div>") if val=="good" || val == "yes"
		return raw("<div class='res-box val-blue'><p>#{val.upcase}</p></div>") if val=="neutral"
		return raw("<div class='res-box val-red'><p>#{val.upcase}</p></div>") if val=="no" || val == "bad"
	end
end
