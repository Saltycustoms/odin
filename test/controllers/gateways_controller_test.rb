require 'test_helper'

class GatewaysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get gateways_index_url
    assert_response :success
  end

  test "should get new" do
    get gateways_new_url
    assert_response :success
  end

  test "should get edit" do
    get gateways_edit_url
    assert_response :success
  end

  test "should get _form" do
    get gateways__form_url
    assert_response :success
  end

end
