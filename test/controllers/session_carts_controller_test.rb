require 'test_helper'

class SessionCartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get session_carts_index_url
    assert_response :success
  end

end
