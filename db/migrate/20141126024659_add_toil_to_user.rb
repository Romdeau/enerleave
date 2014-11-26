class AddToilToUser < ActiveRecord::Migration
  def change
    add_column :users, :can_toil, :boolean, :default => false
  end
end
