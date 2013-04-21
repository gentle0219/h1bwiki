class H1bemp < ActiveRecord::Base
	has_many :h1bemp_filling
  has_many :h1bemp_topjob
  attr_accessible :Workforcesize, :empAddress, :empCity, :empState, :empZip, :employerName, :everifiedFlag, :gcARateFlag, :gcApprovalRate, :gcTotalApplied, :gcTotalDenied, :h1BTotalApplied, :h1TotalDenied, :h1bARateFlag, :h1bApprovalRate, :prevGCFlag, :prevgcCount, :prevh1Count, :prevh1Flag

  FILING_TYPE = ["H1B", "GC"]
  FILING_STATUS = ["CERTIFIED", "CERTIFIED-WITHDRAWN", "DENIED", "WITHDRAWN" ]
  TOP_JOB_TYPES = ["TopAvg", "TopHired"]
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
  def get_top_job_data type
    return if !TOP_JOB_TYPES.include?(type)
    top_job_datas=[]
    top_job_datas << ["Title", "#{type=='TopHired' ? 'Total Hired' : 'Avg Salary' }"]
    self.h1bemp_topjob.where(:flag => type).each do |t_data|
      top_job_data = []
      top_job_data << t_data.employerTitle.to_s
      if type == TOP_JOB_TYPES[0]
        top_job_data << t_data.totalCount.to_f
      else
        top_job_data << t_data.avgSalary.to_f
      end
      
      top_job_datas << top_job_data
    end
    return top_job_datas
  end
end
