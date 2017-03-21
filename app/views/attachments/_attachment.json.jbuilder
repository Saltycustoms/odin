json.extract! attachment, :id, :file_data, :created_at, :updated_at
json.url attachment_url(attachment, format: :json)
