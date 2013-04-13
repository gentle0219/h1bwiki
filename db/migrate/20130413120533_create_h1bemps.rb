class CreateH1bemps < ActiveRecord::Migration
  def change
    create_table :h1bemps do |t|
      t.string :name
      t.string :gc2013
      t.string :gc2012
      t.string :gc2011
      t.string :gc2010
      t.string :gcTotalCertified
      t.string :gcTotalApplied
      t.string :gcApprovalRate
      t.string :LCA_CASE_EMPLOYER_NAME
      t.string :h1b2012
      t.string :h1b2011
      t.string :h1b2010
      t.string :h1bTotalCertified
      t.string :h1bTotalApplied
      t.string :h1bApprovalRate
      t.string :prevH1BFlag
      t.string :prevGCFlag
      t.string :h1bARateFlag
      t.string :gcARateFlag
      t.string :everifiedFlag
      t.string :gcEmp
      t.string :h1Emp
      t.string :evh1Emp
      t.string :evgcEmp
      t.string :WorkforceSize

      t.timestamps
    end
  end
end
