object @user

attributes :id, :username, :email, :auth_code

child :diets do 
  attributes :id, :name, :comment, :diet_type

  child :ordered_meals do
    attributes :id, :name, :time

    child :item_meals do

      attributes :quantity, :id, :item_id
    end
  end
end

child :measures do
  attributes :id, :created_at, :height, :weight
end