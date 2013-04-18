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
	      gcdata = self.h1bemp_filling.where(:filingType=>type, :filingYear=>y.to_s, :filingStatus => status ).first
	      count = gcdata.present? ? gcdata.filingCount.to_i : 0
	      gc_c_data << count
	    end
    	return gc_c_data
    else
    	return
    end
  end

  def get_data type
    type = type.upcase
    if FILING_TYPE.include?(type)
      gc_c_data = []
      gc_c_data << ["Year","CERTIFIED", "CERTIFIED-WITHDRAWN", "DENIED", "WITHDRAWN"]
      (2010..2013).each do |y|
        chart_data = []          
        chart_data << y.to_s
        FILING_STATUS.each do |st|          
          gcdata = self.h1bemp_filling.where(:filingType=>type, :filingYear=>y.to_s, :filingStatus => st ).first
          count = gcdata.present? ? gcdata.filingCount.to_i : 0
          chart_data << count
        end
        gc_c_data << chart_data  
      end      
      return gc_c_data
    else
      return
    end
  end
end
