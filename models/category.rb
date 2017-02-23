class Category < ActiveRecord::Base
	# VALIDATES
  validates :external_code, uniqueness: true
  
  #RELATIONS
  has_many :jobs
end
