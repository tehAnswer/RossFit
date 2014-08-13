class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    items = Item.alphabetical_order
    if item_type = params[:item_type]
      items = items.where(item_type: item_type)
    end
    render json: { item_list: { items: items } }, status: 200
  end

  # GET /items/1
  # GET /items/1.json
  def show
    render json: { item: @item }, status: 200
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # POST /items
  # POST /items.json
  def create
    item = Item.new(item_params)
    if item.save
      render json: {item: item}, status: 200, location: item
    else
      render json: item.errors, status: 422
    end 
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.json { head :no_content, status: 204 }
      else
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    if @item.destroy
      head :no_content, status: 200
    else
      render json: @item.errors, status: 405
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :calories, :fat, :carbohydrates, :protein, :description, :item_type)
    end
end