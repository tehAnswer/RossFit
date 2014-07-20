class ItemMealsController < ApplicationController
  before_action :set_item_meal, only: [:show, :update, :destroy]

  
 
  # POST /item_meals
  # POST /item_meals.json
  def create
    @item_meal = ItemMeal.new(item_meal_params)

    if @item_meal.save
      render json: item_meal.meal, status: 200
    else
      render json: item_meal.errors, status: 422
    end
  end


  # PATCH/PUT /item_meals/1
  # PATCH/PUT /item_meals/1.json
  def update
    respond_to do |format|
      if @item_meal.update(item_meal_params)
        format.json { head :no_content }
      else
        format.json { render json: @item_meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_meals/1
  # DELETE /item_meals/1.json
  def destroy
    @item_meal.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_meal
      @item_meal = ItemMeal.find(params[:id])
      token = request.header[:token]
      
      if token != @item_meal.user.auth_code
        render json: "Forbidden", status: 403
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_meal_params
      params.require(:item_meal).permit(:quantity, :item_id)
    end

end
