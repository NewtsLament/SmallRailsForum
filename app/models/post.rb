class Post < ApplicationRecord
  validates :body, presence: true, allow_blank: false
end
