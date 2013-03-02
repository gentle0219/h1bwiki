class CreatePostJobs < ActiveRecord::Migration
  def change
    create_table :post_jobs do |t|
      t.belongs_to :user
      t.string :job_title
      t.integer :job_type
      t.text :job_description

      t.timestamps
    end
    add_index :post_jobs, :user_id
  end
end
