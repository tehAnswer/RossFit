class DietsController < ApplicationController

  before_action :set_diet, only: [:show, :update, :destroy]
  before_action :check_if_user_exists, only: :create
  before_action :check_for_user_diet, except: [:create]


  # GET /diets/1
  # GET /diets/1.json
  def show
    render json: @diet, status: 200, root: true
  end

  # GET /diets/new
  def new
    @diet = Diet.new
  end

  # POST /diets
  # POST /diets.json
  def create
    @diet = Diet.new(diet_params)
    @diet.user = @current_user

    if @diet.save
      render json: @diet, status: 201, location: @diet, root: true
    else
      render json: @diet.errors, status: 422
    end
  end

  # PATCH/PUT /diets/1
  # PATCH/PUT /diets/1.json
  def update
    if @diet.update(diet_params)
      head :no_content, status: 204
    else
      render json: @diet.errors, status: 422
    end
  end

  # DELETE /diets/1
  # DELETE /diets/1.json
  def destroy
    if @diet.destroy
      head :no_content, status: 200
    else
      render json: @diet.errors, status: 405
    end
  end

  def check_for_user_diet
    check_for_user(@diet)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diet
      @diet = Diet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diet_params
      params.require(:diet).permit(:name, :comment, :diet_type)
    end
end
