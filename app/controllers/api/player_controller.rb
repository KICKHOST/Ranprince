# -*- coding: utf-8 -*-
class Api::PlayerController < Api::BaseController
  def create
    player = Player.new
    player.name = params[:name]
    player.uid = params[:uid]
    return render :json => 'error', :status => :bad_request unless player.save
    render :json => player
  end
end
