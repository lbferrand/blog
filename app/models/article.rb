# this model will add validation to the article model
# The first validation ensures that the title is present,
# and the second validation ensures that the body is present and at least 10 characters long.
class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
