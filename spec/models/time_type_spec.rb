# -*- coding: utf-8 -*-
require 'spec_helper'

describe TimeType do
  describe '#names' do
    context 'when a correct data' do
      subject { TimeType }
      its (:names) { should == ['all', 'daily', 'weekly', 'monthly'] }
    end
  end
end
