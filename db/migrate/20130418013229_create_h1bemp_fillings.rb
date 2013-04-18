class CreateH1bempFillings < ActiveRecord::Migration
  def change
    create_table :h1bemp_fillings do |t|
      t.belongs_to :h1bemp
      t.string :filingType
      t.string :filingYear
      t.string :filingStatus
      t.string :filingCount

      t.timestamps
    end
    add_index :h1bemp_fillings, :h1bemp_id
  end
end
