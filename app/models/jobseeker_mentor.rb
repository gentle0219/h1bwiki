=begin 
	Schema Info
 	t.belongs_to :user
  t.string :title
  t.integer :support
  t.text :description
=end
class JobseekerMentor < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :description, :support, :title

  def self.search( title )
    all :conditions => ["title LIKE ? ", "%"+title+"%" ], :order => :created_at
  end
end
