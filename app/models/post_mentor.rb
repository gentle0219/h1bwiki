class PostMentor < ActiveRecord::Base
  belongs_to :user
  has_many :skills, :as => :skillable
  attr_accessible :user_id, :job_description, :job_interview, :job_title, :skills_attributes

  accepts_nested_attributes_for :skills
  validates :job_description, presence: true
  validates :job_title, :presence => true, :length => {:maximum => 50}

  def get_skill    
    skill_types = ""
    SkillList.find(self.skills.map(&:skill_list_id)).each do |skill|
      skill_types = skill.name + "\n"
    end
    return skill_types
  end
end
