class QuizzesController < ApplicationController

  def index
    @quiz = Quiz.all
  end

  def show
    @quiz = Quiz.find(params[:id])
    # @questions = Question.order("RANDOM()").limit(1)

    # if @quiz.guess == @question.correct_answer
    #   flash[:alert] = 'You got it right!'
    # end
  end

  def new
    @quiz = Quiz.new
    @questions = Question.order("RANDOM()").limit(1)
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user_id = current_user.id

    
    if @quiz.save
      flash[:alert] = 'Quiz submitted successfully!'
      redirect_to user_quiz_path(current_user, @quiz)
    end
  end

  # def edit
  #   @quiz = Quiz.find(params[:id])
  # end

  # def update
  #   @quiz = Quiz.find(params[:id])

  #   if @quiz.update!(quiz_params)
  #     flash[:alert] = 'Quiz submitted successfully!'
  #     redirect_to user_quiz_path(current_user, @quiz)
  #   else
  #     flash[:alert] = 'Quiz could not be submitted!'
  #     render 'edit'
  #   end
  # end


  private
  def quiz_params
    params.require(:quiz).permit(:score, :quiz_category, :user_id, :running_score, :question_id, :guess)
  end

end
