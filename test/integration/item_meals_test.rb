class ItemMealsTest < ActionDispatch::IntegrationTest

  setup do
    user = User.create(username:"Nicki", password:"password", password_confirmation:"password", email:"nicki@minaj.com")
    user.register
    meal = Meal.create(name: "Gotcha", time:"00:19", user: user)

    item = Item.create(name: "Magikarp",
          fat: 19.0,
          carbohydrates: 10,
          protein: 1,
          calories: 30,
          description: "Splash, splash.",
          item_type: "Fish"
      )

    Item.create(name: "LilWayne",
          fat: 19.0,
          carbohydrates: 10,
          protein: 1,
          calories: 30,
          description: "Youuuuung mula.",
          item_type: "Fish"
      )

    ItemMeal.create(item: item, meal: meal, quantity: 300)
  end

  test "create an item meal" do
    @item1 = Item.find_by(name: "Magikarp")
    @item2 = Item.find_by(name:"LilWayne")
    @meal = Meal.find_by(name:"Gotcha")
    @user = User.find_by(username:"Nicki")

    assert_equal 1, @meal.item_meals.count
    assert_equal @item1, @meal.item_meals.first.item


    item_meal_already_added = {
      item_meal: {
        item_id: @item1.id, 
        meal_id: @meal.id
      }
    }

    new_item_meal = {
      item_meal: {
        item_id: @item2.id,
        meal_id: @meal.id
      }
    }

    post "/item_meals", item_meal_already_added, {"Accept" => "application/json"}
    assert_equal 401, response.status
    post "/item_meals", new_item_meal, {"Accept" => "application/json"}
    assert_equal 401, response.status

    post "/item_meals", item_meal_already_added, {"Accept" => "application/json", "Token" => "fake"}
    assert_equal 401, response.status
    post "/item_meals", new_item_meal, {"Accept" => "application/json", "Token" => "fake"}
    assert_equal 401, response.status

    post "/item_meals", item_meal_already_added, {"Accept" => "application/json", "Token" => @user.auth_code}
    assert_equal 422, response.status
    post "/item_meals", new_item_meal, {"Accept" => "application/json", "Token" => @user.auth_code }
    assert_equal 201, response.status
  end

  test "update and item meal" do

    @item1 = Item.find_by(name: "Magikarp")
    @meal = Meal.find_by(name:"Gotcha")

    another_user = User.create(username:"Drake", password:"password", password_confirmation:"password", email:"drizzy@ovo.com")
    another_user.register


    @another_meal = Meal.create!(name: "Hold on we're going home", time: "08:19", user: another_user)
    item_meal = ItemMeal.find_by(item: @item1, meal: @meal)

    wrong_update_item_meal = {
      item_meal: {
        meal_id: @another_meal.id
      }
    }

    correct_update_item_meal = {
      item_meal: {
        quantity: 500
      }
    }

    patch "/item_meals/#{item_meal.id}", wrong_update_item_meal, {"Accept" => "application/json", "Token" => "fake"}
    assert_equal 403, response.status

    patch "/item_meals/#{item_meal.id}", wrong_update_item_meal, {"Accept" => "application/json", "Token" => another_user.auth_code }
    assert_equal 403, response.status 

    patch "/item_meals/#{item_meal.id}", correct_update_item_meal, {"Accept" => "application/json", "Token" => item_meal.user.auth_code }
    assert_equal 204, response.status 

  end

  test "delete an item meal" do 

    @item1 = Item.find_by(name: "Magikarp")
    @meal = Meal.find_by(name:"Gotcha")
    item_meal = ItemMeal.find_by(item: @item1, meal: @meal)

    delete "/item_meals/#{item_meal.id}"
    assert_equal 401, response.status
    delete "/item_meals/#{item_meal.id}", {}, {"Accept" => "application/json", "Token" => "fake"}
    assert_equal 403, response.status
    delete "/item_meals/#{item_meal.id}", {}, {"Accept" => "application/json", "Token" => item_meal.user.auth_code }
    assert_equal 204, response.status
  end

  
end