class MealsController < ApplicationController

  before_action :set_meal, only: [:show, :update, :destroy]
  before_action :check_for_user_meal, except: [:index, :create]
  before_action :check_if_user_exists, only: :create

  # GET /meals
  # GET /meals.json
  def index
    @meals = Meal.all
    render json: @meals, status: 200
  end

  # GET /meals/1
  # GET /meals/1.json
  def show
  end

  # GET /meals/new
  def new
    @meal = Meal.new
  end

  # POST /meals
  # POST /meals.json
  def create
    meal = Meal.new(meal_params)

    if meal.save
      render json: meal, status: 201, location: meal
    else
      render json: meal.errors, status: 422
    end
  end


  # PATCH/PUT /meals/1
  # PATCH/PUT /meals/1.json
  def update
    if @meal.update(meal_params)
      head :no_content, status: 204
    else
      render json: @meal.errors, status: :unprocessable_entity 
    end

  end

  # DELETE /meals/1
  # DELETE /meals/1.json
  def destroy
    if @meal.destroy
      head :no_content, status: 204
    else
      render json: @meal.errors, status: 405
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.find(params[:id])
    end

    def check_for_user_meal
      check_for_user(@meal)
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:name, :time, :diet_id)
    end

    private :set_meal
    protected :check_for_user, :check_if_user_exists
  
end
