class AddPostHireToListings < ActiveRecord::Migration
  def change
    add_column :listings, :posthire, :boolean
  end
end
