class AddForeignKeyToQuizzes < ActiveRecord::Migration[6.0]
  def change
    add_reference(:quizzes, :user, foreign_key: true)
    add_reference(:quizzes, :question, foreign_key: true)
  end
end
