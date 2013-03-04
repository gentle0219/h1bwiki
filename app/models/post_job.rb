class PostJob < ActiveRecord::Base
	attr_accessible :user_id, :job_description, :job_title, :job_type, :skills_attributes, :skill_tokens
  belongs_to :user
  has_many :skills, :as => :skillable, :dependent => :destroy
  has_many :skill_lists, :through => :skills

  accepts_nested_attributes_for :skills
  validates :job_description, presence: true
  validates :job_title, :presence => true, :length => {:maximum => 50, :message => "Please limit length of words to less than 50 characters each."}

  attr_reader :skill_tokens
  def skill_tokens=(ids)
    self.skill_list_ids = ids.split(",")
  end

  JOB_TYPE = ['Full Time','Contract','Contract to Hire']
  def get_jobtype
  	JOB_TYPE[self.job_type.to_i]
  end

  def get_skill    
    skills = ""
    self.skill_lists.each do |skill_name|
      skills += skill_name.name + " "
    end
    skills
  end
end
