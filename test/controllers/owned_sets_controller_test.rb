require 'test_helper'

class OwnedSetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get owned_sets_index_url
    assert_response :success
  end

  test "should get create" do
    get owned_sets_create_url
    assert_response :success
  end

  test "should get destroy" do
    get owned_sets_destroy_url
    assert_response :success
  end

end
