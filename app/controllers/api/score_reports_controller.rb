# -*- coding: utf-8 -*-
class Api::ScoreReportsController < Api::BaseController
  before_filter :authenticate

  def create
    device = Device.find_by_key(params[:device])
    if device.blank? && params[:device].present?
      device = Device.new
      device.name = params[:device]
      device.key = params[:device]
      device.save
    end
    player = Player.find_by_uid(params[:uid])

    score_report = ScoreReport.new
    score_report.score = params[:score].to_f
    score_report.app_id = @app.id
    score_report.device_id = device.id if device.present?
    score_report.player_id = player.id if player.present?
    return render :json => 'error', :status => :bad_request unless score_report.save
    render :json => score_report
  end
end
