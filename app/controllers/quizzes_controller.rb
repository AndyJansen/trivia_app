class QuizzesController < ApplicationController
  def index
    @quizzes = Quiz.all
    @quiz = Quiz.new
  end

  def show
    @quiz = Quiz.find(params[:id])
    @questions = Question.where(:category => @quiz.quiz_category).order("random()").limit(1)
    # @questions = Question.order("RANDOM()").limit(10)

    # @question = @quiz.question_id

    # if @quiz.guess == @question.correct_answer
    #   flash[:alert] = 'You got it right!'
    #   redirect_to user_quizzes_path
    # else
    #   flash[:alert] = "The correct answer was #{@question.correct_answer}"
    #   redirect_to user_quizzes_path
    # end
  end

  def new
    @quiz = Quiz.new
    
    # @quiz.question_id = @question.id
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user_id = current_user.id

    # @questions = Question.where(:category => @quiz.quiz_category)

    if @quiz.save
      flash[:alert] = 'Good Luck!'
      redirect_to user_quiz_path(current_user, @quiz)
    end
  end

  def edit
    @quiz = Quiz.find(params[:id])
  end

  def update
    @quiz = Quiz.find(params[:id])

    if @quiz.update!(quiz_params)
      flash[:alert] = 'Quiz submitted successfully! Try another one below'
      redirect_to user_quizzes_path(current_user, @quiz)
    else
      flash[:alert] = 'Quiz could not be submitted!'
      render 'edit'
    end
  end


  private
  def quiz_params
    params.require(:quiz).permit(:score, :quiz_category, :user_id, :running_score, :question_id, :guess)
  end

end
