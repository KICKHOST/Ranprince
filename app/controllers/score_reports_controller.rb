class ScoreReportsController < ApplicationController
  def index
    @app = App.find(params[:app_id])
    @score_reports = ScoreReport.ranking_search(params)
    @order_param = ['asc', 'desc'].find{ |v| v != params[:order] }
    @device_key = nil
    if params[:device].present?
      device = Device.where(:key => params[:device]).first
      @device_key = device.key if device.present?
    end
    @time_type_name = params[:time_type].present? ? params[:time_type] : nil
  end
end
