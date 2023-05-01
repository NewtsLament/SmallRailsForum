class AddForumThreadToPosts < ActiveRecord::Migration[7.0]
  def change
    add_reference :posts, :forum_thread, null: false, foreign_key: true
  end
end
