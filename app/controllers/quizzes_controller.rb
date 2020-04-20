class QuizzesController < ApplicationController
  before_action :authenticate_user!

  def index
    @quizzes = Quiz.all
    @quiz = Quiz.new
  end

  def show
    @quiz = Quiz.find(params[:id])
    @questions = Question.where(:id => @quiz.question_id)
    @answers = Question.where(:id => @quiz.question_id)
    questions_to_hash = @questions.as_json
    current_question = questions_to_hash[0]["id"]
    @quiz.question_id = current_question

    @answers = [questions_to_hash[0]["correct_answer"], 
                questions_to_hash[0]["answer_option_one"], 
                questions_to_hash[0]["answer_option_two"],
                questions_to_hash[0]["answer_option_three"]].shuffle
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user_id = current_user.id

    @questions = Question.where(:category => @quiz.quiz_category).order("random()").limit(1)
    questions_to_hash = @questions.as_json
    current_question = questions_to_hash[0]["id"]
    @quiz.question_id = current_question

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
    @question = Question.where(:id => @quiz.question_id)
    correct_to_hash = @question.as_json
    correct = correct_to_hash[0]["correct_answer"]
    @user = current_user

    if @quiz.update!(quiz_params) && @quiz.guess == correct
      @quiz.accuracy = true
      @quiz.save!
      @user.score += 4
      @user.save!
      flash[:alert] = 'You got it right! Try another one below'
      redirect_to user_quizzes_path(current_user, @quiz)
    elsif @quiz.update!(quiz_params) && @quiz.guess != correct
      @quiz.accuracy = false
      @quiz.save!
      @user.score -= 1
      @user.save!
      flash[:alert] = "The correct answer was #{correct}. You guessed #{@quiz.guess}.Try another one below"
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
