class User < ApplicationRecord

  def self.now
    Time.now - 18.months
  end

  def self.periods
    7
  end

  def self.signup_data
    data = []
    (periods..1).each do |p|
      # count = User.where('created_at > ?', now - p.days).count
      data << [p,count]
    end
    data
  end

  def self.cancellation_data
    total_users = User.count
    data = []
    periods.times do |p|
      count = total_users - User.where('created_at > ?', now - p.day).count
      data << [p,count]
    end
    data
  end

end
