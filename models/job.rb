class Job < ActiveRecord::Base
	#VALIDATES
  validates :category_id, :expired_at, :partner_id, presence: true
  validates :partner_id, uniqueness: true
  validate :job_expired?

  enum status: { draft: 0, active: 1 }

  # RELATIONS
  belongs_to :category

  def job_expired?
  	if expired_at && expired_at < Date.today
  		errors.add(:expired_at, "job expired")
  	end
  end

  def activate!
  	update(status: 'active')
  end
end
