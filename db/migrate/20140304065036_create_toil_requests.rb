class CreateToilRequests < ActiveRecord::Migration
  def change
    create_table :toil_requests do |t|
      t.references :user, index: true
      t.integer :initial_amount
      t.integer :amount
      t.date :date_accrued
      t.string :approved

      t.timestamps
    end
  end
end
