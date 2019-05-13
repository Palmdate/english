require 'test_helper'

class IpaEnglishControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ipa_english_index_url
    assert_response :success
  end

end
