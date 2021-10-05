require 'test_helper'

class AuthControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get auth_create_url
    assert_response :success
  end

  test "should get destroy" do
    get auth_destroy_url
    assert_response :success
  end

  test "should get logged_in" do
    get auth_logged_in_url
    assert_response :success
  end

end
