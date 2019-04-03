require 'test_helper'

class WriteFrDicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @write_fr_dic = write_fr_dics(:one)
  end

  test "should get index" do
    get write_fr_dics_url
    assert_response :success
  end

  test "should get new" do
    get new_write_fr_dic_url
    assert_response :success
  end

  test "should create write_fr_dic" do
    assert_difference('WriteFrDic.count') do
      post write_fr_dics_url, params: { write_fr_dic: {  } }
    end

    assert_redirected_to write_fr_dic_url(WriteFrDic.last)
  end

  test "should show write_fr_dic" do
    get write_fr_dic_url(@write_fr_dic)
    assert_response :success
  end

  test "should get edit" do
    get edit_write_fr_dic_url(@write_fr_dic)
    assert_response :success
  end

  test "should update write_fr_dic" do
    patch write_fr_dic_url(@write_fr_dic), params: { write_fr_dic: {  } }
    assert_redirected_to write_fr_dic_url(@write_fr_dic)
  end

  test "should destroy write_fr_dic" do
    assert_difference('WriteFrDic.count', -1) do
      delete write_fr_dic_url(@write_fr_dic)
    end

    assert_redirected_to write_fr_dics_url
  end
end
