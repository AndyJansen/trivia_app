class Quiz < ApplicationRecord
  has_one :question
  accepts_nested_attributes_for :question
end
