class MemberMst < ActiveRecord::Base
  validates :menber_name, presence: true
end
