class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    
    @question.save
    # redirect_to user_question_path(current_user, @question)
    redirect_to new_user_question_path
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to user_question_path(current_user, @question)
    else
      render 'edit'
    end
  end


  private
  def question_params
    params.require(:question).permit(:question, :correct_answer, :category, :user_id, :answer_option_one, :answer_option_two,
    :answer_option_three)
  end
end
