class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :job_type
      t.string :languages

      t.timestamps null: false
    end
  end
end
