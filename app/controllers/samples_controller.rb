class SamplesController < ApplicationController
  def index
    @samples = Sample.all
  end

  def update
    @sample = Sample.find(params[:id])
    @sample.ac_comments = sample_params[:ac_comments]
    if @sample.save
      send_notification(@sample, self)
      respond_with_bip(@sample)
    else
      respond_with_bip(@sample)
    end
  end

  private

  def set_sample
    @sample = Sample.find(params[:id])
  end

  def sample_params
    params.require(:sample).permit(:id, :eta_pps, :received_pps, :status, :creative_comments, :ac_comments, attachments_attributes: [:id, :attachment, :attachment_data, :_destroy])
  end
end
