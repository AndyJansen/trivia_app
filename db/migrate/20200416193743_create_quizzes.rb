class CreateQuizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes do |t|
      t.integer :score
      t.integer :running_score

      t.timestamps
    end
  end
end
