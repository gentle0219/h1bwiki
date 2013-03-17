class User < ActiveRecord::Base  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :company_name, :address1, :address2, :city, :user_name, :account_type, :country_id, :immigration_status, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_one :country
  has_many :post_jobs
  has_many :post_trainings
  has_many :post_mentors

  has_many :jobseeker_jobs
  has_many :jobseeker_trainings
  has_many :jobseeker_mentors
  
  include Mailboxer::Models::Messageable
  acts_as_messageable
  def name
    self.to_s
  end
  def mailboxer_email(message)
    email
  end
  def to_s
    email
  end

end
