class RemoveDetailsFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :title
    remove_column :forum_threads, :description
    add_column :forums, :description, :text
  end
end
