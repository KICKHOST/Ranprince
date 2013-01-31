# -*- coding: utf-8 -*-
require 'spec_helper'

describe App do
  describe '#save' do
    context 'when a correct data' do
      let(:app) { FactoryGirl.build :app }
      subject { app }
      it { should be_valid }
      its (:save) { should be_true }
      it 'sould be able to get the data' do
        app.save
        should == App.all.first
      end
    end
    context 'when a empty data' do
      let(:app) { App.new }
      subject { app }
      it { should_not be_valid }
      its (:save) { should be_false }
      it "should be have errors" do
        app.valid?
        should have(1).errors
        should have(1).errors_on :name
      end
    end
    context 'when an incorrect format' do
      let(:app) { FactoryGirl.build :app, :store_url => 'ftp://www.kickhost.jp' }
      subject { app }
      it { should_not be_valid }
      its (:save) { should be_false }
      it "should be have errors" do
        app.valid?
        should have(1).errors
        should have(1).errors_on :store_url
      end
    end
    context 'when the characters has overflowed' do
      let(:app) { FactoryGirl.build :app, :name => 'a' * 101, :store_url => 'http://' + 'a' * 256 }
      subject { app }
      it { should_not be_valid }
      its (:save) { should be_false }
      it "should be have errors" do
        app.valid?
        should have(2).errors
        should have(1).errors_on :name
        should have(1).errors_on :store_url
      end
    end
  end
end
