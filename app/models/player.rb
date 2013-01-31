class Player < ActiveRecord::Base
  attr_accessible :email, :uid

  has_many :players

  # Validation
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 100 }
  validates :uid, :presence => true, :uniqueness => true, :length => { :maximum => 255 }
end
