class MeasuresController < ApplicationController

  before_action :set_measure, only: [:show, :update, :destroy]
  before_action :check_if_user_exists, only: :create
  before_action :check_for_user_measure, except: [:create]

  
  # GET /measures/1
  # GET /measures/1.json
  def show
    render json: @measure, status: 200, root: true
  end

  # GET /measures/new
  def new
    @measure = Measure.new
  end

  # GET /measures/1/edit
  def edit
  end

  # POST /measures
  # POST /measures.json
  def create
    @measure = Measure.new(measure_params)
    @measure.user = @current_user

    if @measure.save
      render json: @measure, status: 201, location: @measure, root: true
    else
      render json: @measure.errors, status: 422
    end  
  end

  # PATCH/PUT /measures/1
  # PATCH/PUT /measures/1.json
  def update
    if @measure.update(measure_params)
      head :no_content, status: 204
    else
      render json: @measure.errors, status: 422
    end  
  end

  # DELETE /measures/1
  # DELETE /measures/1.json
  def destroy
    if @measure.destroy
      head :no_content, status: 200
    else
      render json: @measure.errors, status: 422
    end
  end

  def check_for_user_measure
    check_for_user(@measure)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_measure
      @measure = Measure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def measure_params
      params.require(:measure).permit(:height, :weight)
    end
end
