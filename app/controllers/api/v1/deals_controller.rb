class Api::V1::DealsController < ApiController
  def index
    if params[:q]
      q = Deal.ransack(params[:q])
      @deals = q.result
    else
      @deals = Deal.all
    end
    respond_to do |format|
      format.json {
        if params[:id]
          render json: JSON.parse(@deals.to_json(
            include: {
              quotation: {
                include: {
                  quotation_lines: {
                    only: QuotationLine.column_names
                  },
                  job_requests: {
                    only: JobRequest.column_names,
                    methods: [:selected_colors]
                  }
                },
                only: Quotation.column_names
              },
              quotation_lines: {
                only: QuotationLine.column_names
              },
              add_ons: {
                only: AddOn.column_names
              },
              job_requests: {
                only: JobRequest.column_names
              },
              department: {
                only: Department.column_names
              }
            },  methods: [:display_name, :client_deadline]
          ))
        else
          render json: JSON.parse(@deals.to_json(
                    include: {
                      department: {
                        only: Department.column_names
                      },
                      quotation: {
                        only: Quotation.column_names
                      }
                    }, methods: [:has_quotation]
                  ))
        end
      }
    end
  end

  def show
    @deal = Deal.find_by(id: params[:id])
    respond_to do |format|
      format.json {
        render json: JSON.parse(@deal.to_json(
          include: {
            quotation: {
              include: {
                quotation_lines: {
                  only: QuotationLine.column_names
                },
                job_requests: {
                  only: JobRequest.column_names,
                  methods: [:selected_colors]
                }
              },
              only: Quotation.column_names
            },
            quotation_lines: {
              only: QuotationLine.column_names
            },
            add_ons: {
              only: AddOn.column_names
            },
            job_requests: {
              only: JobRequest.column_names,
              methods: [:selected_colors, :selected_sizes, :product],
              include: {
                attachments: {
                  only: Attachment.column_names,
                  methods: [:attachment_full_url, :attachment, :attachment_original_filename]
                }
              }
            },
            department: {
              only: Department.column_names
            },
            packing_lists: {
              only: PackingList.column_names,
              include: {
                address: {
                  only: Address.column_names,
                  methods: [:to_html]
                },
                pics: {
                  only: Pic.column_names
                },
                packing_list_items: {
                  only: PackingListItem.column_names
                },
                attachments: {
                  only: Attachment.column_names
                }
              }
            }
          },  methods: [:display_name, :client_deadline]
        )) || {}
      }
    end
  end
end
