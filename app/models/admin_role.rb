# == Schema Information
#
# Table name: admin_roles
#
#  id         :integer          not null, primary key
#  admin_id   :integer
#  role       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AdminRole < ApplicationRecord
  belongs_to :admin

  validates :role, :inclusion => { :in => ROLES }

end
