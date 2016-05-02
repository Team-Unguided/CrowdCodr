class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.text :description
      t.string :languages
      t.string :job_type

      t.timestamps null: false
    end
  end
end
