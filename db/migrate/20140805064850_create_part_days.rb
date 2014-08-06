class CreatePartDays < ActiveRecord::Migration
  def change
    create_table :part_days do |t|
      t.references :leave_request, index: true
      t.date :part_date
      t.datetime :part_start
      t.datetime :part_end

      t.timestamps
    end
  end
end
