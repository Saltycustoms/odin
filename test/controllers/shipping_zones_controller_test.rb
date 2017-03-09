require 'test_helper'

class ShippingZonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shipping_zone = shipping_zones(:one)
  end

  test "should get index" do
    get shipping_zones_url
    assert_response :success
  end

  test "should get new" do
    get new_shipping_zone_url
    assert_response :success
  end

  test "should create shipping_zone" do
    assert_difference('ShippingZone.count') do
      post shipping_zones_url, params: { shipping_zone: { disabled: @shipping_zone.disabled, name: @shipping_zone.name } }
    end

    assert_redirected_to shipping_zone_url(ShippingZone.last)
  end

  test "should show shipping_zone" do
    get shipping_zone_url(@shipping_zone)
    assert_response :success
  end

  test "should get edit" do
    get edit_shipping_zone_url(@shipping_zone)
    assert_response :success
  end

  test "should update shipping_zone" do
    patch shipping_zone_url(@shipping_zone), params: { shipping_zone: { disabled: @shipping_zone.disabled, name: @shipping_zone.name } }
    assert_redirected_to shipping_zone_url(@shipping_zone)
  end

  test "should destroy shipping_zone" do
    assert_difference('ShippingZone.count', -1) do
      delete shipping_zone_url(@shipping_zone)
    end

    assert_redirected_to shipping_zones_url
  end
end
