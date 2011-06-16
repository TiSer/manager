require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get employees_bookings" do
    get :employees_bookings
    assert_response :success
  end

end
