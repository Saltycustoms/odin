require "shrine"
require "shrine/storage/file_system"

Shrine.storages = {
  cache: Shrine::Storage::FileSystem.new("public", host: "http://192.168.0.247:3000", prefix: "uploads/cache"), # temporary
  store: Shrine::Storage::FileSystem.new("public", host: "http://192.168.0.247:3000", prefix: "uploads/store"), # permanent
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
