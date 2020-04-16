Rails.application.routes.draw do
  root 'questions#index'
  devise_for :users

  resources :users do
    resources :questions
    resources :quizzes
  end
end
