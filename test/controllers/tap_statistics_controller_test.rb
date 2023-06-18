require "test_helper"

class TapStatisticsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tap_statistic = tap_statistics(:one)
  end

  test "should get index" do
    get tap_statistics_url, as: :json
    assert_response :success
  end

  test "should create tap_statistic" do
    example_params = 
    {
      "username": "jan_kowalski",
      "measurements": [
      {
        "frequency": 100,
        "responseTime": 0.2
      },
      {
        "frequency": 200,
        "responseTime": 0.21
      },
      {
        "frequency": 500,
        "responseTime": 0.19
      }]
    }

    assert_difference("TapStatistic.count") do
      post tap_statistics_url, params: example_params, as: :json
    end

    assert_response :created
  end

  test "should show tap_statistic" do
    get tap_statistic_url(@tap_statistic), as: :json
    assert_response :success
  end
end
