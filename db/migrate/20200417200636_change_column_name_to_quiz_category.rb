class ChangeColumnNameToQuizCategory < ActiveRecord::Migration[6.0]
  def change
    rename_column :quizzes, :category, :quiz_category
  end
end
