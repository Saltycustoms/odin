require "shrine"
if Rails.env.production?
  require "shrine/storage/s3"

  s3_options = {
    access_key_id:     "",
    secret_access_key: "",
    region:            "ap-southeast-1",
    bucket:            "",
  }

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
    store: Shrine::Storage::S3.new(prefix: "store", **s3_options),
  }

else
  require "shrine/storage/file_system"

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"), # permanent
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
