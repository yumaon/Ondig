require "test_helper"

class Public::LiveSchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_live_schedules_index_url
    assert_response :success
  end
end
