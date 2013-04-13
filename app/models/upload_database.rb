class UploadDatabase < ActiveRecord::Base
  attr_accessible :data_content, :table_name
  after_create :import_data
  validates :table_name, :data_content, presence: true
  H1BEMP_COLSIZE = 25
  def import_data
  	#data_content
    logger = Logger.new("log/upload_database.log") unless logger
    contents = UploadDatabase.last
    content = contents.data_content
    table_name = contents.table_name
    
    lines = content.split(/\r/)
    logger.info"Step2 #{table_name}"
    headers = lines[0].split(/\,/)
    return nil if headers.size < 7
          
    lines.each_with_index do |line, index|
      next if index == 0     
      result = UploadDatabase.update_table(table_name, line, headers, :return_if_existed, logger) #rescue nil
      logger.info"INDEX ====== #{index}"
    end
      
    rescue Exception => e
      logger.info e.message
  end
  def self.update_table(table_name, textline, headers, action_type = :updated_if_existed, logger = nil)
  	logger = Logger.new("log/upload_database.log") unless logger
  	columns = textline.split(/,/).map{|value| value.strip}
  	logger.info "columns.size: #{columns.size} - headers.size: #{headers.size}"
  	
  	if table_name == "h1b_employer"
  		return if columns.size < H1BEMP_COLSIZE || columns.size > headers.size
	  	logger.info "Table name: #{table_name}"
  		to_upload_table = H1bemp.where(:name => columns[0]).first

	  	if to_upload_table
	  		return to_upload_table unless action_type
	  	else
	  		logger.info "New table name: #{table_name}"
				to_upload_table = H1bemp.new(:name=>columns[0])				
				to_upload_table.gc2013 				= columns[1]
				to_upload_table.gc2012 				= columns[2]
				to_upload_table.gc2011 				= columns[3]
				to_upload_table.gc2010 				= columns[4]
				to_upload_table.gcTotalCertified = columns[5]
				to_upload_table.gcTotalApplied = columns[6]
				to_upload_table.gcApprovalRate = columns[7]
				to_upload_table.LCA_CASE_EMPLOYER_NAME = columns[8]
				to_upload_table.h1b2012 			= columns[9]
				to_upload_table.h1b2011 			= columns[10]
				to_upload_table.h1b2010 			= columns[11]
				to_upload_table.h1bTotalCertified = columns[12]
				to_upload_table.h1bTotalApplied = columns[13]
				to_upload_table.h1bApprovalRate = columns[14]
				to_upload_table.prevH1BFlag 	= columns[15]
				to_upload_table.prevGCFlag 		= columns[16]
				to_upload_table.h1bARateFlag 	= columns[17]
				to_upload_table.gcARateFlag 	= columns[18]
				to_upload_table.everifiedFlag = columns[19]
				to_upload_table.gcEmp 				= columns[20]
				to_upload_table.h1Emp 				= columns[21]
				to_upload_table.evh1Emp 			= columns[22]
				to_upload_table.evgcEmp 			= columns[23]
				to_upload_table.WorkforceSize = columns[24]				

				if to_upload_table.save
					logger.info "New Table #{table_name} save"
				end
	  	end
  	end  	
  end 
end
