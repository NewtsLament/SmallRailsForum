class CreateForumThreads < ActiveRecord::Migration[7.0]
  def change
    create_table :forum_threads do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
