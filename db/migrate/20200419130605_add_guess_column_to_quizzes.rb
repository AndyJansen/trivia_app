class AddGuessColumnToQuizzes < ActiveRecord::Migration[6.0]
  def change
    add_column :quizzes, :guess, :string
  end
end
