class AddSubjectIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :subject_id, :integer
  end
end
