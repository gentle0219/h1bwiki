class H1bemp < ActiveRecord::Base
	has_many :h1bemp_filling
  attr_accessible :Workforcesize, :empAddress, :empCity, :empState, :empZip, :employerName, :everifiedFlag, :gcARateFlag, :gcApprovalRate, :gcTotalApplied, :gcTotalDenied, :h1BTotalApplied, :h1TotalDenied, :h1bARateFlag, :h1bApprovalRate, :prevGCFlag, :prevgcCount, :prevh1Count, :prevh1Flag

  FILING_TYPE = ["H1B", "GC"]
  FILING_STATUS = ["CERTIFIED", "CERTIFIED-WITHDRAWN", "DENIED", "WITHDRAWN" ]

  def get_filing_data type, status
    type = type.upcase
    status = status.upcase
    if FILING_TYPE.include?(type) && FILING_STATUS.include?(status)
	    gc_c_data = []		
	    (2010..2013).each do |y|
	      gcdata = self.h1bemp_filling.where(:filingType=>type, :filingYear=>y, :filingStatus => status ).first
	      count = gcdata.present? ? gcdata.filingCount.to_i : 0
	      gc_c_data << count
	    end
    	return gc_c_data
    else
    	return
    end
  end
end
