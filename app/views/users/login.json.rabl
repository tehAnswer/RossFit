object @user

attributes :id, :username, :email, :auth_code

child :diets do 
  attributes :id, :name, :comment, :diet_type

  child :meals do
    attributes :id, :name, :time

    child :item_meals do

      attributes :quantity, :meal_id

      child :item do
        attributes :id, :name, :protein, :carbohydrates, :fat, :item_type
      end
    end
  end
end