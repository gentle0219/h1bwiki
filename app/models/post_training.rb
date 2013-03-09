class PostTraining < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :job_accomodation, :job_description, :job_duration, :job_city, :job_state, :job_instruction, :job_placement, :job_technology, :job_title, :skills_attributes

  validates :job_description, :job_duration, presence: true
  validates :job_title, :presence => true, :length => {:maximum => 50}
  TECH_TYPE = ['Java','Datastage']
  INSTRUCTION_MODE = ['Class Room', 'Online', 'Class Room & Online']

  def get_techtype
  	TECH_TYPE[self.job_technology.to_i]
  end
  def get_instruction_mode
  	INSTRUCTION_MODE[self.job_instruction.to_i]
  end  
end
