require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "home and posts render after replacing Webpacker" do
    get root_path
    assert_response :success
    assert_select "script[type=module]"

    get posts_path
    assert_response :success
  end
end
