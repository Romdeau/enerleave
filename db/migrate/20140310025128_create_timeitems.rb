class CreateTimeitems < ActiveRecord::Migration
  def change
    create_table :timeitems do |t|
      t.references :user, index: true
      t.references :timesheet, index: true
      t.date :start_time
      t.date :end_time
      t.string :description
      t.references :cost_center, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
