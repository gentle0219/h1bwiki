class PostJob < ActiveRecord::Base
	attr_accessible :user_id, :job_description, :job_title, :job_type, :job_city, :job_state, :job_duration, :skills_attributes, :skill_tokens, :work_authorizations_attributes, :authors_names
  belongs_to :user
  has_many :skills, :as => :skillable, :dependent => :destroy
  has_many :skill_lists, :through => :skills
  has_many :work_authorizations, :dependent => :destroy

  accepts_nested_attributes_for :skills
  accepts_nested_attributes_for :work_authorizations, :reject_if => proc{ |a| a['workauthorization_index'] == '-1' }

  validates :job_description, presence: true
  validates :job_title, :presence => true, :length => {:maximum => 50, :message => "Please limit length of words to less than 50 characters each."}

  attr_reader :skill_tokens
  attr_reader :authors_names
  def skill_tokens=(ids)
    self.skill_list_ids = ids.split(",")
  end
  def authors_names=(names)
    self.work_authorization_names=names
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
