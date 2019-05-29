require 'test_helper'

class PronunciationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pronunciation_index_url
    assert_response :success
  end

end
