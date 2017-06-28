class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :edit, :update]


  def index
    @exercises = current_user.exercises.all
  end

  def show
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)
    if @exercise.save
      flash[:notice] = "Way to go! You've added a new exercise!"
      redirect_to [current_user, @exercise] # user_exercise_path, /users/:user_id/exercises/:id
    else
      flash[:alert] = "Oops! Unable to create exercise."
      render :new
    end
  end

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      flash[:notice] = "Exercise has been updated."
      redirect_to [current_user, @exercise]
    else
      flash[alert] = "Oops! Unable to update exercise."
      render :edit
    end
  end

  private
    def set_exercise
      @exercise = current_user.exercises.find params[:id]
    end

    def exercise_params
      params.require(:exercise).permit(:duration, :workout_details, :activity_date, :user_id)
    end
end
