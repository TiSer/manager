require 'test_helper'

class MonthWorkingDaysControllerTest < ActionController::TestCase
  setup do
    @month_working_day = month_working_days(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:month_working_days)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create month_working_day" do
    assert_difference('MonthWorkingDay.count') do
      post :create, :month_working_day => @month_working_day.attributes
    end

    assert_redirected_to month_working_day_path(assigns(:month_working_day))
  end

  test "should show month_working_day" do
    get :show, :id => @month_working_day.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @month_working_day.to_param
    assert_response :success
  end

  test "should update month_working_day" do
    put :update, :id => @month_working_day.to_param, :month_working_day => @month_working_day.attributes
    assert_redirected_to month_working_day_path(assigns(:month_working_day))
  end

  test "should destroy month_working_day" do
    assert_difference('MonthWorkingDay.count', -1) do
      delete :destroy, :id => @month_working_day.to_param
    end

    assert_redirected_to month_working_days_path
  end
end
