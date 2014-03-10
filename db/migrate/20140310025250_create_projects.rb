class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :project_number, index: true
      t.string :description

      t.timestamps
    end
  end
end
