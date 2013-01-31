# -*- coding: utf-8 -*-
require 'spec_helper'

describe Player do
  describe '#save' do
    context 'when a correct data' do
      let(:player) { FactoryGirl.build :player }
      subject { player }
      it { should be_valid }
      its (:save) { should be_true }
      it 'sould be able to get the data' do
        player.save
        should == Player.all.first
      end
    end
    context 'when a empty data' do
      let(:player) { Player.new }
      subject { player }
      it { should_not be_valid }
      its (:save) { should be_false }
      it "should be have errors" do
        player.valid?
        should have(2).errors
        should have(1).errors_on :name
        should have(1).errors_on :uid
      end
    end
    context 'when a duplicate data.' do
      before do
        FactoryGirl.create :player
      end
      let(:player) { FactoryGirl.build :player }
      subject { player }
      it { should_not be_valid }
      its (:save) { should be_false }
      it "should be have errors" do
        player.valid?
        should have(2).errors
        should have(1).errors_on :name
        should have(1).errors_on :uid
      end
    end
    context 'when the characters has overflowed' do
      let(:player) { FactoryGirl.build :player, :name => 'a' * 101, :uid => 'a' * 256 }
      subject { player }
      it { should_not be_valid }
      its (:save) { should be_false }
      it "should be have errors" do
        player.valid?
        should have(2).errors
        should have(1).errors_on :name
        should have(1).errors_on :uid
      end
    end
  end
end
