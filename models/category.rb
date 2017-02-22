class Category < ActiveRecord::Base
  validates :external_code, uniqueness: true
end
