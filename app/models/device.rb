class Device < ActiveRecord::Base
  attr_accessible :name, :key
  
  has_many :score_reports

  # Validation
  validates :name, :presence => true, :length => { :maximum => 100 }
  validates :key, :presence => true, :uniqueness => true, :length => { :maximum => 100 }

  OTHER_DEVICE_ID = 1
end
