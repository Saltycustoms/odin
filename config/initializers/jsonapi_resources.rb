JSONAPI.configure do |config|
  # built in paginators are :none, :offset, :paged
  config.default_paginator = :paged
  config.default_page_size = 2
  config.maximum_page_size = 3

  config.top_level_meta_include_record_count = true
  config.top_level_meta_include_page_count = true
end
