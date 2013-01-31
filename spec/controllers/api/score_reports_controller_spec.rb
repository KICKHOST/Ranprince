# -*- coding: utf-8 -*-
require 'spec_helper'

describe Api::ScoreReportsController do
  describe "POST create" do
    context 'when the request is invalid' do
      before { post :create }
      subject { response }
      it { should be_bad_request }
    end
    let(:app) { FactoryGirl.create :app }
    context 'when the parameters is empty' do
      before { post :create, :app_key => app.app_key }
      subject { response }
      it { should be_bad_request }
    end
    let(:player) { FactoryGirl.create :player }
    let(:device) { FactoryGirl.create :device }
    context 'when the device does not exist' do
      let(:new_device) { 'Palm' }
      before { post :create, :app_key => app.app_key, :score => 100, :device => new_device, :uid => player.uid }
      subject { response }
      it { should be_success }
      it 'should be a new device' do
        Device.find_by_key(new_device).should be_present
      end
    end
    context 'when the player does not exist' do
      before { post :create, :app_key => app.app_key, :score => 100, :device => device.key, :uid => 'SoManySmiles' }
      subject { response }
      it { should be_bad_request }
    end
    context 'when the posted the correct request' do
      before { post :create, :app_key => app.app_key, :score => 100, :device => device.key, :uid => player.uid }
      subject { response }
      it { should be_success }
      its(:body) { should eq(ScoreReport.all.first.to_json) }
    end
    context 'when the posted the device empty' do
      before { post :create, :app_key => app.app_key, :score => 100, :uid => player.uid }
      subject { response }
      it { should be_success }
      its(:body) { should eq(ScoreReport.all.first.to_json) }
    end
  end
end
