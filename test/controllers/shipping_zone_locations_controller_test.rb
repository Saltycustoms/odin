require 'test_helper'

class ShippingZoneLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shipping_zone_location = shipping_zone_locations(:one)
  end

  test "should get index" do
    get shipping_zone_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_shipping_zone_location_url
    assert_response :success
  end

  test "should create shipping_zone_location" do
    assert_difference('ShippingZoneLocation.count') do
      post shipping_zone_locations_url, params: { shipping_zone_location: { country_code: @shipping_zone_location.country_code, shipping_zone_id: @shipping_zone_location.shipping_zone_id, state: @shipping_zone_location.state } }
    end

    assert_redirected_to shipping_zone_location_url(ShippingZoneLocation.last)
  end

  test "should show shipping_zone_location" do
    get shipping_zone_location_url(@shipping_zone_location)
    assert_response :success
  end

  test "should get edit" do
    get edit_shipping_zone_location_url(@shipping_zone_location)
    assert_response :success
  end

  test "should update shipping_zone_location" do
    patch shipping_zone_location_url(@shipping_zone_location), params: { shipping_zone_location: { country_code: @shipping_zone_location.country_code, shipping_zone_id: @shipping_zone_location.shipping_zone_id, state: @shipping_zone_location.state } }
    assert_redirected_to shipping_zone_location_url(@shipping_zone_location)
  end

  test "should destroy shipping_zone_location" do
    assert_difference('ShippingZoneLocation.count', -1) do
      delete shipping_zone_location_url(@shipping_zone_location)
    end

    assert_redirected_to shipping_zone_locations_url
  end
end
