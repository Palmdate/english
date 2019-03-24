require 'test_helper'

class CourseControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get course_create_url
    assert_response :success
  end

  test "should get store" do
    get course_store_url
    assert_response :success
  end

end
