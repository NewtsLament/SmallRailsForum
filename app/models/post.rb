class Post < ApplicationRecord
  validates :body, presence: true, allow_blank: false

  belongs_to :user
  belongs_to :forum_thread
end
