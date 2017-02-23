class CategoryService
  attr_accessor :id
  def initialize(id)
    @id = id
  end

  def calculate
    category = Category.find id
    category_jobs_count = category.jobs.size
    category_jobs_active_count = category.jobs.where(status: 'active').size
    { 
      title: category.title, 
      total: category_jobs_count, 
      active: category_jobs_active_count,
      percent: calculate_percent(category_jobs_count, category_jobs_active_count) 
    }
  end

  def calculate_percent(total, jobs_active)
    ((jobs_active.to_f / total.to_f) * 100.0) || 0
  end
end