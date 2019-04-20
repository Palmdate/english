require 'test_helper'

class BuildControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get build_index_url
    assert_response :success
  end

end
