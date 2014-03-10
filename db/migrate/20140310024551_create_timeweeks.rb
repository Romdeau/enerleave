class CreateTimeweeks < ActiveRecord::Migration
  def change
    create_table :timeweeks do |t|
      t.references :user, index: true
      t.date :start_date, index: true

      t.timestamps
    end
  end
end
