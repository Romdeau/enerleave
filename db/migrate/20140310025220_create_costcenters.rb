class CreateCostcenters < ActiveRecord::Migration
  def change
    create_table :costcenters do |t|
      t.string :cost_code, index: true
      t.string :description

      t.timestamps
    end
  end
end
