# == Schema Information
#
# Table name: admins
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  avatar                 :string(255)
#  phone                  :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :timeoutable

  # has_many :notifications
  has_many :admin_roles

  def full_name
    "#{first_name} #{last_name}"
  end

  def avatar_display
    if avatar == 'none'
      "gallery/#{[1, 2, 3, 4, 5, 6, 7, 8].sample}"
    else
      "avatars/#{full_name.downcase.tr(' ', '-')}"
    end
  end

  def system_role
    admin_roles.where(role: 'system').count > 0
  end

  def package_role
    admin_roles.where(role: 'package').count > 0
  end

  def marketing_role
    admin_roles.where(role: 'marketing').count > 0
  end

  def self.current
    Thread.current[:admin]
  end

  def self.current=(user)
    Thread.current[:admin] = user
  end

  def super_admin?
    email == 'admin@demo.com'
  end

  def nurse?
    email == 'nurse@demo.com' || super_admin?
  end

  def provider?
    email == 'provider@demo.com' || super_admin?
  end
end
