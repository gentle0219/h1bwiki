class User < ActiveRecord::Base  
  ajaxful_rater
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :company_name, :address1, :address2, :city, :user_name, :account_type, :country_id, :immigration_status, :email, :password, :password_confirmation, :remember_me, :contact_number, :approved
  # attr_accessible :title, :body
  #has_one :country
  has_many :post_jobs
  has_many :applicants
  
  has_many :post_trainings
  has_many :post_mentors

  has_many :jobseeker_jobs
  has_many :jobseeker_trainings
  has_many :jobseeker_mentors
  
  has_one :company
  has_one :contact
  include Mailboxer::Models::Messageable
  acts_as_messageable
  def full_name
    [self.first_name, self.last_name].reject(&:blank?).join(" ")
  end
  def name
    self.to_s
  end
  def mailboxer_email(message)
    email
  end
  def to_s
    email
  end
  def is_admin?
    self.email == "gentle0219@gmail.com"
  end

  def is_employer?
    return true if self.account_type == "employer"
    return false
  end
  def is_seeker?
    return true if self.account_type == "jobseeker"
    return false
  end

  def active_for_authentication? 
    if self.is_employer?
      super && approved? 
    else
      super
    end
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    if !recoverable.approved?
      recoverable.errors[:base] << I18n.t("devise.failure.not_approved")
    elsif recoverable.persisted?
      recoverable.send_reset_password_instructions
    end
    recoverable
  end
end
