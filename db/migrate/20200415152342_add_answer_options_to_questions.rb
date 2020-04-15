class AddAnswerOptionsToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :answer_option_one, :string
    add_column :questions, :answer_option_two, :string
    add_column :questions, :answer_option_three, :string
  end
end
