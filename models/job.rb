class Job < ActiveRecord::Base
  validates :category_id, :expired_at, :partner_id, presence: true
  validates :partner_id, uniqueness: true
end
