# -*- coding: utf-8 -*-
class Api::BaseController < ApplicationController
  private
  def authenticate
    @app = App.find_by_app_key(params[:app_key])
    return render :json => 'error', :status => :bad_request unless @app.present?
  end
end
