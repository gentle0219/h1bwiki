class UploadDatabase < ActiveRecord::Base
  attr_accessible :data_content, :table_name
  after_create :import_data
  validates :table_name, :data_content, presence: true
  H1BEMP_COLSIZE = 19
  H1BEMP_FILLING_COLSIZE = 5
  H1BEMP_TOPJOBS_COLSIZE = 6
  def import_data
  	#data_content
    logger = Logger.new("log/upload_#{table_name}.log") unless logger
    contents = UploadDatabase.last
    content = contents.data_content
    table_name = contents.table_name
    
    lines = content.split(/\r/)
    logger.info"Step1 #{table_name}"
    headers = lines[0].split(/\,/)
        
    lines.each_with_index do |line, index|
      next if index == 0     
      result = UploadDatabase.update_table(table_name, line, headers, :return_if_existed, logger) #rescue nil
      logger.info">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{index}" if result.present?
    end
      
    rescue Exception => e
      logger.info e.message
  end
  def self.update_table(table_name, textline, headers, action_type = :updated_if_existed, logger = nil)
  	logger = Logger.new("log/upload_#{table_name}.log") unless logger
  	columns = textline.split(/,/).map{|value| value.strip}
  	logger.info "Step 2 columns.size: #{columns.size} - headers.size: #{headers.size}---------table name: #{table_name}"
  	to_upload_table = nil
  	if table_name == "h1bemp"
  		return if columns.size < H1BEMP_COLSIZE || columns.size > headers.size
  		to_upload_table = H1bemp.where(:employerName => columns[0]).first

	  	if to_upload_table
	  		logger.info "Step 3 Update Table: #{columns[0]}"
	  		return to_upload_table unless action_type	  		
	  		to_upload_table.empAddress 			= columns[1]
				to_upload_table.empCity 				= columns[2]
				to_upload_table.empState 				= columns[3]
				to_upload_table.empZip 					= columns[4]
				to_upload_table.h1BTotalApplied = columns[5]
				to_upload_table.h1TotalDenied 	= columns[6]
				to_upload_table.h1bApprovalRate = columns[7]
				to_upload_table.prevh1Count 		= columns[8]
				to_upload_table.gcTotalApplied 	= columns[9]
				to_upload_table.gcTotalDenied 	= columns[10]
				to_upload_table.gcApprovalRate 	= columns[11]
				to_upload_table.prevgcCount 		= columns[12]
				to_upload_table.prevh1Flag 			= columns[13]
				to_upload_table.prevGCFlag 			= columns[14]
				to_upload_table.h1bARateFlag 		= columns[15]
				to_upload_table.gcARateFlag 		= columns[16]
				to_upload_table.everifiedFlag 	= columns[17]
				to_upload_table.Workforcesize 	= columns[18]
	  	else
        logger.info "Step 3 Insert Table: #{columns[0]}"
				to_upload_table = H1bemp.new(:employerName=>columns[0])				
				to_upload_table.empAddress 			= columns[1]
				to_upload_table.empCity 				= columns[2]
				to_upload_table.empState 				= columns[3]
				to_upload_table.empZip 					= columns[4]
				to_upload_table.h1BTotalApplied = columns[5]
				to_upload_table.h1TotalDenied 	= columns[6]
				to_upload_table.h1bApprovalRate = columns[7]
				to_upload_table.prevh1Count 		= columns[8]
				to_upload_table.gcTotalApplied 	= columns[9]
				to_upload_table.gcTotalDenied 	= columns[10]
				to_upload_table.gcApprovalRate 	= columns[11]
				to_upload_table.prevgcCount 		= columns[12]
				to_upload_table.prevh1Flag 			= columns[13]
				to_upload_table.prevGCFlag 			= columns[14]
				to_upload_table.h1bARateFlag 		= columns[15]
				to_upload_table.gcARateFlag 		= columns[16]
				to_upload_table.everifiedFlag 	= columns[17]
				to_upload_table.Workforcesize 	= columns[18]
				
				if to_upload_table.save
					logger.info "Insert data >>>>>>>>>>> #{columns[0]}"
				end
	  	end
  	elsif table_name == "h1bemp_filling" 
			return if columns.size < H1BEMP_FILLING_COLSIZE || columns.size > H1BEMP_FILLING_COLSIZE

	  	h1bemp = H1bemp.find_by_employerName(columns[0])
	  	
	  	if h1bemp.present?
	  		h1bemp_id = h1bemp.id 	
	  	else
	  		logger.info "h1bemp_id: NULL ====== #{columns[0]}"	
	  		return
	  	end
	  		  	
  		to_upload_table = H1bempFilling.where(:h1bemp_id => h1bemp_id, :filingType => columns[1], :filingYear => columns[2], :filingStatus => columns[3] ).first
  		if to_upload_table
  			logger.info "Step 3 Update Table: #{columns[0]}"
	  		return to_upload_table unless action_type
	  		to_upload_table.filingCount = columns[4]
	  	else
	  		logger.info "Step 3 Insert Table: #{columns[0]}"
	  		h1bemp_id = H1bemp.find_by_employerName(columns[0]).id
	  		to_upload_table = H1bempFilling.new(:h1bemp_id=>h1bemp_id)
	  		to_upload_table.filingType 		= columns[1]
	  		to_upload_table.filingYear		= columns[2]
	  		to_upload_table.filingStatus	= columns[3]
	  		to_upload_table.filingCount 	= columns[4]
	  	end
	  	if to_upload_table.save
				logger.info "Table #{table_name}------------#{columns[0]} insert successfully"				
				return to_upload_table
			end
		elsif table_name == "h1bemp_topjob"
			return if columns.size < H1BEMP_TOPJOBS_COLSIZE || columns.size > H1BEMP_TOPJOBS_COLSIZE

	  	h1bemp = H1bemp.find_by_employerName(columns[0])
	  	
	  	if h1bemp.present?
	  		h1bemp_id = h1bemp.id
	  	else
	  		logger.info "h1bemp_id: NULL ====== #{columns[0]}"	
	  		return
	  	end
	  	
  		to_upload_table = H1bempTopjob.where(:h1bemp_id => h1bemp_id, :employerTitle => columns[1], :flag => columns[4] ).first
  		if to_upload_table
  			logger.info "Step 3 Update Table: #{columns[0]}"
	  		return to_upload_table unless action_type
	  		to_upload_table.totalCount = columns[2]
	  		to_upload_table.avgSalary = columns[3]
	  		to_upload_table.rn = columns[5]
	  	else
	  		logger.info "Step 3 Insert Table: #{columns[0]}"
#	  		h1bemp_id = H1bemp.find_by_employerName(columns[0]).id
	  		to_upload_table = H1bempTopjob.new(:h1bemp_id=>h1bemp_id)
	  		to_upload_table.employerTitle 		= columns[1]
	  		to_upload_table.totalCount		= columns[2]
	  		to_upload_table.avgSalary	= columns[3]
	  		to_upload_table.flag 	= columns[4]
	  		to_upload_table.rn 	= columns[5]
	  	end
	  	if to_upload_table.save
				logger.info "Table #{table_name}------------#{columns[0]} insert successfully"				
				return to_upload_table
			end
  	end

  end 
end
