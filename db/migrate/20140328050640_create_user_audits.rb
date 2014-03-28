class CreateUserAudits < ActiveRecord::Migration
  def change
    create_table :user_audits do |t|
      t.references :user, index: true
      t.string :action
      t.string :description
      t.string :end_user

      t.timestamps
    end
  end
end
