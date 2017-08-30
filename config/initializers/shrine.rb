require "shrine"
if Rails.env.production?
  require "shrine/storage/s3"

  s3_options = {
    access_key_id:     "AKIAILKV4TT6IQ3CK7CA",
    secret_access_key: "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",
    region:            "ap-southeast-1",
    bucket:            "thehand",
  }

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: "hades_cache", **s3_options),
    store: Shrine::Storage::S3.new(prefix: "hades_store", **s3_options),
  }

else
  require "shrine/storage/s3"

  s3_options = {
    access_key_id:     "AKIAILKV4TT6IQ3CK7CA",
    secret_access_key: "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",
    region:            "ap-southeast-1",
    bucket:            "thehand",
  }

  Shrine.storages = {
    cache: Shrine::Storage::S3.new(prefix: "hades_cache_dev", **s3_options),
    store: Shrine::Storage::S3.new(prefix: "hades_store_dev", **s3_options),
  }
end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
