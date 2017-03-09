require 'test_helper'

class ShippingMethodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shipping_method = shipping_methods(:one)
  end

  test "should get index" do
    get shipping_methods_url
    assert_response :success
  end

  test "should get new" do
    get new_shipping_method_url
    assert_response :success
  end

  test "should create shipping_method" do
    assert_difference('ShippingMethod.count') do
      post shipping_methods_url, params: { shipping_method: { calculator_id: @shipping_method.calculator_id, name: @shipping_method.name, properties: @shipping_method.properties, shipping_zone_id: @shipping_method.shipping_zone_id, type: @shipping_method.type } }
    end

    assert_redirected_to shipping_method_url(ShippingMethod.last)
  end

  test "should show shipping_method" do
    get shipping_method_url(@shipping_method)
    assert_response :success
  end

  test "should get edit" do
    get edit_shipping_method_url(@shipping_method)
    assert_response :success
  end

  test "should update shipping_method" do
    patch shipping_method_url(@shipping_method), params: { shipping_method: { calculator_id: @shipping_method.calculator_id, name: @shipping_method.name, properties: @shipping_method.properties, shipping_zone_id: @shipping_method.shipping_zone_id, type: @shipping_method.type } }
    assert_redirected_to shipping_method_url(@shipping_method)
  end

  test "should destroy shipping_method" do
    assert_difference('ShippingMethod.count', -1) do
      delete shipping_method_url(@shipping_method)
    end

    assert_redirected_to shipping_methods_url
  end
end
