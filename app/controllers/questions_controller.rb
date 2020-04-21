class QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    user = current_user
    @questions = Question.where(:user_id => user.id)
    @user = current_user
    @high_scores = User.order(score: :desc).limit(10)
    @low_scores = User.order(score: :asc).limit(10)

    most_accurate_category = Quiz.group(:quiz_category).where(accuracy: true, :user_id => user.id).count
    @best_category = most_accurate_category.key(most_accurate_category.values.max)

   
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    
    if @question.save
      flash[:alert] = 'Question saved successfully!'
      redirect_to new_user_question_path
    else 
      flash[:alert] = 'Question could not be saved'
      redirect_to new_user_question_path
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update!(question_params)
      flash[:alert] = 'Question updated successfully!'
      redirect_to user_question_path(current_user, @question)
    else
      flash[:alert] = 'Question could not be updated!'
      render 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy!

    redirect_to root_path(current_user)
  end

  private
  def question_params
    params.require(:question).permit( :question, :correct_answer, :category, :user_id, :answer_option_one, :answer_option_two,
    :answer_option_three)
  end

end
