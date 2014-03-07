class AddDateAccruedEndToToilRequests < ActiveRecord::Migration
  def change
  	add_column :toil_requests, :date_accrued_end, :date
  end
end
