# -*- coding: utf-8 -*-
require 'spec_helper'

describe ScoreReport do
  describe '#save' do
    context 'when a correct data' do
      let(:score_report) {
        FactoryGirl.build :score_report,
        :app => FactoryGirl.create(:app),
        :device => FactoryGirl.create(:device),
        :player => FactoryGirl.create(:player)
      }
      subject { score_report }
      it { should be_valid }
      its (:save) { should be_true }
      it 'sould be able to get the data' do
        score_report.save
        should == ScoreReport.all.first
      end
    end
    context 'when a empty data' do
      let(:score_report) { ScoreReport.new :score => nil }
      subject { score_report }
      it { should_not be_valid }
      its (:save) { should be_false }
      it "should be have errors" do
        score_report.valid?
        should have(3).errors
        should have(1).errors_on :score
        should have(1).errors_on :app_id
        should have(1).errors_on :player_id
      end
    end
    context 'when the characters has overflowed' do
      let(:score_report) {
        FactoryGirl.build :score_report,
        :app => FactoryGirl.create(:app),
        :device => FactoryGirl.create(:device),
        :player => FactoryGirl.create(:player),
        :score => ('9' * 14).to_i
      }
      subject { score_report }
      it { should_not be_valid }
      its (:save) { should be_false }
      it "should be have errors" do
        score_report.valid?
        should have(1).errors
        should have(1).errors_on :score
      end
    end

  end
  describe 'scope' do
    let(:app) { FactoryGirl.create :app }
    let(:device) { FactoryGirl.create :device }
    let(:player) { FactoryGirl.create :player }
    let(:score_report_high) { FactoryGirl.create :score_report_high, :app => app, :device => device, :player => player }
    let(:score_report_mid) { FactoryGirl.create :score_report_mid, :app => app, :device => device, :player => player }
    let(:score_report_low) { FactoryGirl.create :score_report_low, :app => app, :device => device, :player => player }
    let(:score_reports) { [score_report_high, score_report_mid, score_report_low ] }
    describe '#score_asc' do
      subject { score_reports.reverse }
      it 'should be able to get the data' do
        should == ScoreReport.score_asc
      end
    end
    describe '#score_desc' do
      subject { score_reports }
      it 'should be able to get the data' do
        score_reports.should == ScoreReport.score_desc
      end
    end
    describe '#score_order' do
      context 'when the argument "asc"' do
        subject { score_reports.reverse }
        it 'should be able to get the data' do
          should == ScoreReport.score_order('asc')
        end
      end
      context 'when the argument "desc"' do
        subject { score_reports }
        it 'should be able to get the data' do
          should == ScoreReport.score_order('desc')
        end
      end
    end
    let(:score_report_today) { FactoryGirl.create :score_report_today, :app => app, :device => device, :player => player }
    let(:score_report_1week_ago) { FactoryGirl.create :score_report_1week_ago, :app => app, :device => device, :player => player }
    let(:score_report_1month_ago) { FactoryGirl.create :score_report_1month_ago, :app => app, :device => device, :player => player }
    describe '#daily' do
      subject { [score_report_today] }
      it 'should be able to get the data' do
        should == ScoreReport.daily
      end
    end
    describe '#weekly' do
      subject { [score_report_today, score_report_1week_ago] }
      it 'should be able to get the data' do
        should == ScoreReport.weekly
      end
    end
    describe '#monthly' do
      subject { [score_report_today, score_report_1week_ago, score_report_1month_ago] }
      it 'should be able to get the data' do
        should == ScoreReport.monthly
      end
    end
  end
  describe '.ranking_search' do
    let(:app) { FactoryGirl.create :app }
    let(:device) { FactoryGirl.create :device }
    let(:player) { FactoryGirl.create :player }
    let(:params) { {:app_id => app.id, :device => nil, :order => nil, :time_type => nil} }
    let(:score_report) { FactoryGirl.create :score_report, :app => app, :device => device, :player => player }
    context 'when there is no search conditions' do
      it 'should be able to get the data' do
        ScoreReport.ranking_search(params).should eq([score_report])      
      end      
    end
    context 'when the device is present in the search condition' do
      it 'should be able to get the data' do
        params[:device] = device.key
        ScoreReport.ranking_search(params).should eq([score_report])      
      end      
    end
    context 'when the order is present in the search condition' do
      let(:score_report_high) { FactoryGirl.create :score_report_high, :app => app, :device => device, :player => player }
      let(:score_report_low) { FactoryGirl.create :score_report_low, :app => app, :device => device, :player => player }
      it 'should be able to get the data' do
        params[:order] = 'asc'
        ScoreReport.ranking_search(params).should eq([score_report_low, score_report, score_report_high])      
      end      
    end
    context 'when the time_type is present in the search condition' do
      let(:score_report_today) { FactoryGirl.create :score_report_today, :app => app, :device => device, :player => player }
      let(:score_report_1week_ago) { FactoryGirl.create :score_report_1week_ago, :app => app, :device => device, :player => player }
      it 'should be able to get the data' do
        params[:time_type] = 'weekly'
        ScoreReport.ranking_search(params).should eq([score_report_1week_ago, score_report_today])      
      end      
    end
  end
end
