ActiveAdmin.register PostJob do
  index do
    column :id, :sortable => true
    column :job_type do |post_job|
      if post_job.job_type == 0
        "Full Time"
      else
        "Contract"
      end
    end
    column :job_title    
    column :job_description
    column :salary
    column :hourly_rate
    column :referral_amount
    column :created_at
    actions    
  end
end