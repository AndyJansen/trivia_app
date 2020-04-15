class ChangeColumnNameToQuestions < ActiveRecord::Migration[6.0]
  def change
    rename_column :questions, :answer, :correct_answer
  end
end
