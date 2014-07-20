require 'test_helper'

class ItemsTest < ActionDispatch::IntegrationTest

	setup do 
		Item.create(name: "Magikarp",
					fat: 19.0,
					carbohydrates: 10,
					protein: 1,
					calories: 30,
					description: "Splash, splash.",
					item_type: "Fish"
			)

	end
	
	test "create an item" do
		item = {
			item: {
				name: "Banana",
				fat: 10.10,
				carbohydrates: 10.0,
				protein: 10.0,
				calories: 1000,
				description: "The banana is a really enjoyable fruit.",
				item_type: "Fruit"
			}
		}

			post '/items', item, {"Accept" => "application/json"}
			assert_equal response.status, 200
			assert_equal response.content_type, Mime::JSON
			item = json(response.body)[:item]

			assert_equal item[:name], "Banana"
			assert_equal item[:fat].to_f, 10.10
			assert_equal item[:calories].to_f, 1000
			assert_equal item[:description], "The banana is a really enjoyable fruit."
			assert_equal item[:item_type], "Fruit"

	
	end

	test "update an item" do
		id = Item.all.first.id
		name = Random.rand(100).to_s + "update" + Random.rand(100).to_s
		item = {
			item: {
				name: name,
				item_type: "Fish"
			} 
		}
		patch "/items/#{id}", item,  {"Accept" => "application/json"}
		assert_equal response.status, 204
		get "/items/#{id}"

		item = json(response.body)[:item]
		assert_equal item[:name], name
	end

	test "delete a no-reference item" do
		item = Item.find_by(name: "Magikarp")
		delete "/items/#{item.id}"
		assert_equal response.status, 204
	end

	test "try to delete a reference item" do
		item = Item.create!(name: "Nicki Minaj",
					fat: 19.0,
					carbohydrates: 10,
					protein: 1,
					calories: 30,
					description: "I endorse that b*tches.",
					item_type: "Meat"
			)
		meal = Meal.create!(name: "Nicki with mustard",
					time: "00:59")
		item_meal = ItemMeal.create!(item_id: item.id,
								meal_id: meal.id)
		delete "/items/#{item.id}"
		assert_equal response.status, 405


	end

	test "get all the items" do 
		get '/items'

		assert_equal response.content_type, Mime::JSON
		assert_equal response.status, 200

		items = json(response.body)[:items]
		assert_equal items.count, Item.all.count
	end

	


end