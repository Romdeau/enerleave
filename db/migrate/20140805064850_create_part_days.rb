class CreatePartDays < ActiveRecord::Migration
  def change
    create_table :part_days do |t|
      t.references :leave_request, index: true
      t.datetime :leave_date
      t.integer :time

      t.timestamps
    end
  end
end
