if @deal
  json.id @deal.id
  json.name @deal.name

  json.job_requests @deal.job_requests do |job_request|
    json.id job_request.id
    json.name job_request.name
  end
end
