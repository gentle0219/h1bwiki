class H1bempTopjob < ActiveRecord::Base
  belongs_to :h1bemp
  attr_accessible :h1bemp_id, :avgSalary, :employerTitle, :flag, :rn, :totalCount
end
