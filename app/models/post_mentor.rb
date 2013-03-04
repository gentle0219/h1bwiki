class PostMentor < ActiveRecord::Base
  belongs_to :user
  has_many :skills, :as => :skillable
  has_many :skill_lists, :through => :skills
  attr_accessible :user_id, :job_description, :job_interview, :job_title, :skills_attributes, :skill_tokens

  accepts_nested_attributes_for :skills
  validates :job_description, presence: true
  validates :job_title, :presence => true, :length => {:maximum => 50}
  
  attr_reader :skill_tokens
  def skill_tokens=(ids)
    self.skill_list_ids = ids.split(",")
  end

  def get_skill    
    skills = ""
    self.skill_lists.each do |skill_name|
      skills += skill_name.name + " "
    end
    skills
  end
end
