# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :score_report do
    score 1.5
    created_at Time.now + 1.day
  end
  factory :score_report_high, :parent => :score_report do
    score 100
  end
  factory :score_report_mid, :parent => :score_report do
    score 50
  end
  factory :score_report_low, :parent => :score_report do
    score 0
  end
  factory :score_report_today, :parent => :score_report do
    created_at Time.now
  end
  factory :score_report_1week_ago, :parent => :score_report do
    created_at Time.now - 1.week
  end
  factory :score_report_1month_ago, :parent => :score_report do
    created_at Time.now - 1.month
  end
end
