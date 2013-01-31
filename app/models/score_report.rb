class ScoreReport < ActiveRecord::Base
  attr_accessible :score

  belongs_to :app
  belongs_to :device
  belongs_to :player

  # Validation
  validates :app_id, :presence => true
  validates :player_id, :presence => true
  validates :score, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 9999999999999 }

  # Scope
  scope :score_asc, order(:score, :created_at)
  scope :score_desc, order('score desc', :created_at)
  scope :score_order, lambda { |t| t == 'asc' ? self.score_asc : self.score_desc }
  scope :daily, where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day)
  scope :weekly, where(:created_at => (Time.now - 7.day).beginning_of_day..Time.now.end_of_day)
  scope :monthly, where(:created_at => (Time.now - 1.month).beginning_of_day..Time.now.end_of_day)

  def self.ranking_search(params)
    app = params[:app_id].present? ? App.find_by_id(params[:app_id]) : App.find_by_app_key(params[:app_key])
    score_reports = ScoreReport.where(:app_id => app.id)
    order_param = params[:order].present? ? params[:order].downcase : nil
    score_reports = score_reports.score_order(order_param)
    if params[:device].present?
      device = Device.where(:key => params[:device].downcase).first
      score_reports = score_reports.where(:device_id => device.id) if device.present?
    end
    if params[:time_type].present?
      case params[:time_type].downcase
        when TimeType::DAILY
          score_reports = score_reports.daily
        when TimeType::WEEKLY
          score_reports = score_reports.weekly
        when TimeType::MONTHLY
          score_reports = score_reports.monthly
      end
    end
    score_reports
  end
end
