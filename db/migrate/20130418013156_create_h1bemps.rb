class CreateH1bemps < ActiveRecord::Migration
  def change
    create_table :h1bemps do |t|
      t.string :employerName
      t.string :empAddress
      t.string :empCity
      t.string :empState
      t.string :empZip
      t.string :h1BTotalApplied
      t.string :h1TotalDenied
      t.string :h1bApprovalRate
      t.string :prevh1Count
      t.string :gcTotalApplied
      t.string :gcTotalDenied
      t.string :gcApprovalRate
      t.string :prevgcCount
      t.string :prevh1Flag
      t.string :prevGCFlag
      t.string :h1bARateFlag
      t.string :gcARateFlag
      t.string :everifiedFlag
      t.string :Workforcesize

      t.timestamps
    end
  end
end
