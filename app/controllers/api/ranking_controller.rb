# -*- coding: utf-8 -*-
class Api::RankingController < Api::BaseController
  before_filter :authenticate
  
  def index
    render :json => ScoreReport.ranking_search(params)
  end
end
