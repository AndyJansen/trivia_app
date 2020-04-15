class Question < ApplicationRecord
  belongs_to :user, optional: true
end
