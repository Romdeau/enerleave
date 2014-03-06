class CreateSpendToils < ActiveRecord::Migration
  def change
    create_table :spend_toils do |t|
      t.references :user
      t.integer :initial_amount
      t.integer :amount
      t.date :leave_date
      t.string :approved

      t.timestamps
    end
  end
end
