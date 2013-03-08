class JobseekerTraining < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :accomodation, :description, :instruction_mod, :status, :technology, :title, :transfer

  IMMIGRATION_STATUS = ['No Status (Not in USA)', 'OPT / CPT', 'H-1B', 'L-1 / L-2', 'H-4']
  INSTRUCTION_MODE=['Class Room', 'Online', 'Class Room & Online']
  def get_immigration_status
		IMMIGRATION_STATUS[self.status.to_i]
  end
  def get_instruction_mode
  	INSTRUCTION_MODE[self.instruction_mod.to_i]
  end
end
