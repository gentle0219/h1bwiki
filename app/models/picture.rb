class Picture < ActiveRecord::Base
  attr_accessible :name, :image

  belongs_to :imageable, :polymorphic=>true
  
  has_attached_file :image, :styles => { :thumb => "80x80>", :medium => "200x200>"},
                    :url  => "/assets/pictures/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/pictures/:style/:basename.:extension"

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end
