class PageCountPaginator < JSONAPI::Paginator
  attr_reader :limit, :offset

  def initialize(params)
    parse_pagination_params(params)
    verify_pagination_params
  end

  def self.requires_record_count
    true
  end

  def apply(relation, _order_options)
    relation.offset(@offset).limit(@limit)
  end

  def links_page_params(options = {})
    record_count = options[:record_count]
    links_page_params = {}

    links_page_params['first'] = {
      'offset' => 0,
      'limit' => @limit
    }

    if @offset > 0
      previous_offset = @offset - @limit

      previous_offset = 0 if previous_offset < 0

      links_page_params['prev'] = {
        'offset' => previous_offset,
        'limit' => @limit
      }
    end

    next_offset = @offset + @limit

    unless next_offset >= record_count
      links_page_params['next'] = {
        'offset' => next_offset,
        'limit' => @limit
      }
    end

    if record_count
      last_offset = record_count - @limit

      last_offset = 0 if last_offset < 0

      links_page_params['last'] = {
        'offset' => last_offset,
        'limit' => @limit
      }
    end

    links_page_params
  end

  def calculate_page_count(record_count)
    total_page_count = record_count / limit
    total_page_count += 1 if (record_count % limit) > 0
    total_page_count
  end

  private

  def parse_pagination_params(params)
    if params.nil?
      @offset = 0
      @limit = JSONAPI.configuration.default_page_size
    elsif params.is_a?(ActionController::Parameters)
      validparams = params.permit(:offset, :limit)

      @offset = validparams[:offset] ? validparams[:offset].to_i : 0
      @limit = validparams[:limit] ? validparams[:limit].to_i : JSONAPI.configuration.default_page_size
    else
      fail JSONAPI::Exceptions::InvalidPageObject.new
    end
  rescue ActionController::UnpermittedParameters => e
    raise JSONAPI::Exceptions::PageParametersNotAllowed.new(e.params)
  end

  def verify_pagination_params
    if @limit < 1
      fail JSONAPI::Exceptions::InvalidPageValue.new(:limit, @limit)
    elsif @limit > JSONAPI.configuration.maximum_page_size
      fail JSONAPI::Exceptions::InvalidPageValue.new(:limit, @limit,
                                                     detail: "Limit exceeds maximum page size of #{JSONAPI.configuration.maximum_page_size}.")
    end

    if @offset < 0
      fail JSONAPI::Exceptions::InvalidPageValue.new(:offset, @offset)
    end
  end
end
