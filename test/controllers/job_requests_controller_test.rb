require 'test_helper'

class JobRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_request = job_requests(:one)
  end

  test "should get index" do
    get job_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_job_request_url
    assert_response :success
  end

  test "should create job_request" do
    assert_difference('JobRequest.count') do
      post job_requests_url, params: { job_request: { budget: @job_request.budget, client_comment: @job_request.client_comment, color_id: @job_request.color_id, deal_id: @job_request.deal_id, hang_tag: @job_request.hang_tag, name: @job_request.name, pantone_code: @job_request.pantone_code, product_id: @job_request.product_id, relabeling: @job_request.relabeling, remark: @job_request.remark, sample_required: @job_request.sample_required, sleeve: @job_request.sleeve, woven_tag: @job_request.woven_tag } }
    end

    assert_redirected_to job_request_url(JobRequest.last)
  end

  test "should show job_request" do
    get job_request_url(@job_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_request_url(@job_request)
    assert_response :success
  end

  test "should update job_request" do
    patch job_request_url(@job_request), params: { job_request: { budget: @job_request.budget, client_comment: @job_request.client_comment, color_id: @job_request.color_id, deal_id: @job_request.deal_id, hang_tag: @job_request.hang_tag, name: @job_request.name, pantone_code: @job_request.pantone_code, product_id: @job_request.product_id, relabeling: @job_request.relabeling, remark: @job_request.remark, sample_required: @job_request.sample_required, sleeve: @job_request.sleeve, woven_tag: @job_request.woven_tag } }
    assert_redirected_to job_request_url(@job_request)
  end

  test "should destroy job_request" do
    assert_difference('JobRequest.count', -1) do
      delete job_request_url(@job_request)
    end

    assert_redirected_to job_requests_url
  end
end
