class CreateToilRequests < ActiveRecord::Migration
  def change
    create_table :toil_requests do |t|
      t.string :user_id
      t.string :claim_date
      t.string :claim_hours
      t.string :approver_id

      t.timestamps
    end
  end
end
