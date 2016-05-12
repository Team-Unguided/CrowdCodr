class AddProjectsToListings < ActiveRecord::Migration
  def change
    add_column :listings, :projects, :string
  end
end
