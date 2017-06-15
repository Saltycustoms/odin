require 'test_helper'

class PrintDetailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @print_detail = print_details(:one)
  end

  test "should get index" do
    get print_details_url
    assert_response :success
  end

  test "should get new" do
    get new_print_detail_url
    assert_response :success
  end

  test "should create print_detail" do
    assert_difference('PrintDetail.count') do
      post print_details_url, params: { print_detail: { attachment_data: @print_detail.attachment_data, block: @print_detail.block, color_count: @print_detail.color_count, job_request_id: @print_detail.job_request_id, position: @print_detail.position, print_method: @print_detail.print_method } }
    end

    assert_redirected_to print_detail_url(PrintDetail.last)
  end

  test "should show print_detail" do
    get print_detail_url(@print_detail)
    assert_response :success
  end

  test "should get edit" do
    get edit_print_detail_url(@print_detail)
    assert_response :success
  end

  test "should update print_detail" do
    patch print_detail_url(@print_detail), params: { print_detail: { attachment_data: @print_detail.attachment_data, block: @print_detail.block, color_count: @print_detail.color_count, job_request_id: @print_detail.job_request_id, position: @print_detail.position, print_method: @print_detail.print_method } }
    assert_redirected_to print_detail_url(@print_detail)
  end

  test "should destroy print_detail" do
    assert_difference('PrintDetail.count', -1) do
      delete print_detail_url(@print_detail)
    end

    assert_redirected_to print_details_url
  end
end
