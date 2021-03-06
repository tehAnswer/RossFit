class MeasuresTest < ActionDispatch::IntegrationTest

  setup do
    user = User.create!(username:"Nicki", password:"password", password_confirmation:"password", email:"nicki@minaj.com")
    user.register
  end

  test "create a measure" do
    user = User.find_by(username:"Nicki")
    measure = {
      measure: {
        height: "170",
        weight: "70"
      }
    }


    post "/measures", measure, {"Accept" => "application/json", "Token" => user.auth_code}
    assert_equal 201, response.status
    post "/measures", measure, {"Accept" => "application/json", "Token" => "fake"}
    assert_equal 401, response.status
    assert_equal 1, user.measures.count
  end

  test "edit a measure" do
    user = User.find_by(username:"Nicki")
    measure = Measure.create!(height: 170, weight: 200, user: user)


    update = {
      measure: {
        height: "160"
      }
    }
    patch "/measures/#{measure.id}", update, {"Accept" => "application/json", "Token" => user.auth_code}
    assert_equal 204, response.status 
    patch "/measures/#{measure.id}", update, {"Accept" => "application/json", "Token" => "fake"}
    assert_equal 403, response.status
  end


  test "delete a measure" do
    measure = Measure.create!(height: 170, weight: 200, user: User.first)

    delete "/measures/#{measure.id}"
    assert_equal 401, response.status

    delete "/measures/#{measure.id}", {}, {"Accept" => "application/json", "Token" => "fake"}
    assert_equal 403, response.status

    delete "/measures/#{measure.id}", {}, {"Accept" => "application/json", "Token" => measure.user.auth_code }
    assert_equal 204, response.status
  end 
end