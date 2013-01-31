# -*- coding: utf-8 -*-
require 'spec_helper'

describe Api::PlayerController do
  describe "POST create" do
    context 'when the request is invalid' do
      before { post :create }
      subject { response }
      it { should be_bad_request }
    end
    context 'when the name is a duplicate' do
      let(:player) { FactoryGirl.create :player }
      before { post :create, :name => player.name, :uid => 'kickhost' }
      subject { response }
      it { should be_bad_request }
    end
    context 'when the email is a duplicate' do
      let(:player) { FactoryGirl.create :player }
      before { post :create, :name => 'bonita', :uid => player.uid }
      subject { response }
      it { should be_bad_request }
    end
    context 'when the posted the correct request.' do
      let(:player) { FactoryGirl.build :player }
      before { post :create, :name => player.name, :uid => player.uid }
      subject { response }
      it { should be_success }
      its(:body) { should eq(Player.all.first.to_json) }
    end
  end
end
