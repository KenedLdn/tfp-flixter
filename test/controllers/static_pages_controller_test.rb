require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_response :success
  end
end
