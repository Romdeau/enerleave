class AddManagerEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :manager_email, :string
  end
end
