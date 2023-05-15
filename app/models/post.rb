class Post < ApplicationRecord
  validates :body, presence: true, allow_blank: false

  belongs_to :user
end
