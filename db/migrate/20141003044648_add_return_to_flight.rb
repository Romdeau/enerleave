class AddReturnToFlight < ActiveRecord::Migration
  def change
    add_column :flights, :return, :boolean
  end
end
