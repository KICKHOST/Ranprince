# -*- coding: utf-8 -*-
class DevicesController < ApplicationController
  def index
    @devices = Device.all
  end

  def show
    @device = Device.find(params[:id])
  end

  def new
    @device = Device.new
  end

  def edit
    @device = Device.find(params[:id])
  end

  def create
    @device = Device.new(params[:device])
    if @device.save
      redirect_to @device, notice: 'Device was successfully created.'
    else
      render action: "new"
    end
  end
  def update
    @device = Device.find(params[:id])
    if @device.update_attributes(params[:device])
      redirect_to @device, notice: 'Device was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @device = Device.find(params[:id])
    @device.destroy
    redirect_to devices_url
  end
end
