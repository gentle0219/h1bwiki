class PostJob < ActiveRecord::Base
	attr_accessible :user_id, :job_description, :job_title, :job_type, :skills_attributes
  belongs_to :user
  has_many :skills, :as => :skillable, :dependent => :destroy

  accepts_nested_attributes_for :skills
  validates :job_description, presence: true
  validates :job_title, :presence => true, :length => {:maximum => 50, :message => "Please limit length of words to less than 50 characters each."}

  JOB_TYPE = ['Full Time','Contract','Contract to Hire']
  def get_jobtype
  	JOB_TYPE[self.job_type.to_i]
  end
  def skill_list_ids=(ids)
    self.skill_list_ids = ids.split(",")
  end
  def get_skill    
    skill_types = ""
    SkillList.find(self.skills.map(&:skill_list_id)).each do |skill|
      skill_types = skill.name + "\n"
    end
    return skill_types
  end
end
