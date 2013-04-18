class H1bempFilling < ActiveRecord::Base
  belongs_to :h1bemp
  attr_accessible :h1bemp_id, :filingCount, :filingStatus, :filingType, :filingYear
end
