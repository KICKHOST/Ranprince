class TimeType
  ALL = 'all'
  DAILY = 'daily'
  WEEKLY = 'weekly'
  MONTHLY = 'monthly'

  def self.names
    [self::ALL, self::DAILY, self::WEEKLY, self::MONTHLY]
  end
end
