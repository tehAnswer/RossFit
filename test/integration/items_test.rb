require 'test_helper'

class ItemsTest < ActionDispatch::IntegrationTest

	setup do 
		Item.create!(name: "Magikarp",
					fat: 19.0,
					carbohydrates: 10,
					protein: 1,
					calories: 30,
					description: "Splash, splash.",
					item_type: "Fish"
			)

	end
	
	test "create a item" do
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

	test "update a item" do
		item = Item.all.first
		id = item.id
		item = {
			item: {
				name: "update"
			} 
		}
		patch "/items/#{id}", item,  {"Accept" => "application/json"}
		assert_equal response.status, 204
		get "/items/#{id}"
		
		item = json(response.body)[:item]
		assert_equal item[:name], "update"
	end

	test "delete a no-reference item" do

	end

	test "try to delete a reference item" do

	end

	test "get all the items" do 
		get '/items'

		assert_equal response.content_type, Mime::JSON
		assert_equal response.status, 200

		items = json(response.body)[:items]
		assert_equal items.count, Item.all.count
	end

	


end