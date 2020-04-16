class QuizzesController < ApplicationController
  def index
    @questions = Question.order("RANDOM()").limit(10)
    # user_category = @questions.find_by(params[:category])
    categories = Question.distinct.pluck(:category)
  end

end
