class AddReturnDateToFlight < ActiveRecord::Migration
  def change
    add_column :flights, :return_date, :datetime
  end
end
