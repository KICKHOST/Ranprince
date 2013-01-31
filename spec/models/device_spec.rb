# -*- coding: utf-8 -*-
require 'spec_helper'

describe Device do
  describe '#save' do
    context 'when a correct data' do
      let(:device) { FactoryGirl.build :device }
      subject { device }
      it { should be_valid }
      its (:save) { should be_true }
      it 'sould be able to get the data' do
        device.save
        should == Device.all.first
      end
    end
    context 'when a empty data' do
      let(:device) { Device.new }
      subject { device }
      it { should_not be_valid }
      its (:save) { should be_false }
      it "should be have errors" do
        device.valid?
        should have(2).errors
        should have(1).errors_on :name
        should have(1).errors_on :key
     end
    end
    context 'when a duplicate data.' do
      before do
        FactoryGirl.create :device
      end
      let(:device) { FactoryGirl.build :device }
      subject { device }
      it { should_not be_valid }
      its (:save) { should be_false }
      it "should be have errors" do
        device.valid?
        should have(1).errors
        should have(1).errors_on :key
      end
    end
    context 'when the characters has overflowed' do
      let(:device) { FactoryGirl.build :device, :name => 'a' * 101, :key => 'a' * 101 }
      subject { device }
      it { should_not be_valid }
      its (:save) { should be_false }
      it "should be have errors" do
        device.valid?
        should have(2).errors
        should have(1).errors_on :name
        should have(1).errors_on :key
      end
    end
  end
end
