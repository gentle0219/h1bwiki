class JobseekerMentor < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :description, :support, :title
end
