class SkillList < ActiveRecord::Base
  attr_accessible :name
  has_one :skill
end
