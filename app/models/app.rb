# -*- coding: utf-8 -*-
class App < ActiveRecord::Base
  attr_accessible :icon, :name, :store_url

  has_many :score_reports
  has_attached_file :icon,
    :path => ":rails_root/public/images/:class/:attachment/:id/:style.:extension",
    :url => "/images/:class/:attachment/:id/:style.:extension"
    
  # Validation
  validates :name, :presence => true, :length => { :maximum => 100 }
  validates :store_url, :format => { :with => /^https?:\/\/.*/i, :allow_blank => true }, :length => { :maximum => 255 }

  before_create do |app|
    milliseconds = Time.now.instance_eval { '%s.%03d' % [strftime('%Y%m%d%H%M%S'), (usec / 1000.0).round] }
    write_attribute(:app_key, Digest::SHA2.hexdigest("#{app.name}#{milliseconds}"))
  end

  def app_key=(value)
    p 'This attribute is read only.'
  end
end
