require "test_helper"

class ViewsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get views_index_url
    assert_response :success
  end
end
