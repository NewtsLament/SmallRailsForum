class ForumThread < ApplicationRecord
  has_many :posts
  belongs_to :forum
end
