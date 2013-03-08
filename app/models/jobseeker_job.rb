class JobseekerJob < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :description, :status, :title, :transfer
  IMMIGRATION_STATUS = ['No Status (Not in USA)', 'OPT / CPT', 'H-1B', 'L-1 / L-2', 'H-4']
  def get_immigration_status
		IMMIGRATION_STATUS[self.status.to_i]
  end
end
