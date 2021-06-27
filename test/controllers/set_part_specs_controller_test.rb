require 'test_helper'

class SetPartSpecsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get set_part_specs_index_url
    assert_response :success
  end

end
