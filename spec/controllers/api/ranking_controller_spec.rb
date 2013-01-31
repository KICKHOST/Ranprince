# -*- coding: utf-8 -*-
require 'spec_helper'

describe Api::RankingController do
  describe "GET index" do
    context 'when the request is invalid' do
      before { get :index }
      its(:response) { should be_bad_request }
    end
    context 'when a correct request' do
      let(:app) { FactoryGirl.create :app }
      let(:score_report) {
        FactoryGirl.create :score_report,
        :app => app,
        :device => FactoryGirl.create(:device),
        :player => FactoryGirl.create(:player)
      }
      before { get :index, :app_key => app.app_key }
      its(:response) { should be_success }
      it 'should be content type of json' do
        response['Content-Type'].should == 'application/json; charset=utf-8'
      end
      # it 'should be able to get data' do
      #   p ScoreReport.all
      #   response.body.should eq(score_report.to_json)
      # end
    end
  end
end
