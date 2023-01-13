require "test_helper"

class Admin::PublicUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_public_users_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_public_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_public_users_edit_url
    assert_response :success
  end
end
