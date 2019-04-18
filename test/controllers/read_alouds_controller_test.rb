require 'test_helper'

class ReadAloudsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @read_aloud = read_alouds(:one)
  end

  test "should get index" do
    get read_alouds_url
    assert_response :success
  end

  test "should get new" do
    get new_read_aloud_url
    assert_response :success
  end

  test "should create read_aloud" do
    assert_difference('ReadAloud.count') do
      post read_alouds_url, params: { read_aloud: {  } }
    end

    assert_redirected_to read_aloud_url(ReadAloud.last)
  end

  test "should show read_aloud" do
    get read_aloud_url(@read_aloud)
    assert_response :success
  end

  test "should get edit" do
    get edit_read_aloud_url(@read_aloud)
    assert_response :success
  end

  test "should update read_aloud" do
    patch read_aloud_url(@read_aloud), params: { read_aloud: {  } }
    assert_redirected_to read_aloud_url(@read_aloud)
  end

  test "should destroy read_aloud" do
    assert_difference('ReadAloud.count', -1) do
      delete read_aloud_url(@read_aloud)
    end

    assert_redirected_to read_alouds_url
  end
end
