json.extract! job_request, :id, :deal_id, :product_id, :color_id, :name, :sleeve, :relabeling, :woven_tag, :hang_tag, :pantone_code, :remark, :sample_required, :budget, :client_comment, :created_at, :updated_at
json.url job_request_url(job_request, format: :json)
