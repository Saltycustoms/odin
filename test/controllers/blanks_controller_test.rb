require 'test_helper'

class BlanksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blank = blanks(:one)
  end

  test "should get index" do
    get blanks_url
    assert_response :success
  end

  test "should get new" do
    get new_blank_url
    assert_response :success
  end

  test "should create blank" do
    assert_difference('Blank.count') do
      post blanks_url, params: { blank: { meta: @blank.meta, name: @blank.name, price_cents: @blank.price_cents } }
    end

    assert_redirected_to blank_url(Blank.last)
  end

  test "should show blank" do
    get blank_url(@blank)
    assert_response :success
  end

  test "should get edit" do
    get edit_blank_url(@blank)
    assert_response :success
  end

  test "should update blank" do
    patch blank_url(@blank), params: { blank: { meta: @blank.meta, name: @blank.name, price_cents: @blank.price_cents } }
    assert_redirected_to blank_url(@blank)
  end

  test "should destroy blank" do
    assert_difference('Blank.count', -1) do
      delete blank_url(@blank)
    end

    assert_redirected_to blanks_url
  end
end
