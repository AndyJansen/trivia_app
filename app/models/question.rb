class Question < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :quizzes, optional: true

end
