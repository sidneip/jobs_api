class JobService
  attr_acessor :partner_id, :title, :category_external_code, :expired_at

  def initialize(params = {})
    params.each do |k, v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end

  def save
    find_or_create_category
    Job
      .create_with(
        category_id: category.id,
        expired_at: expired_at
      )
      .find_or_create_by(
        partner_id: partner_id
      )
  end

  private

  def find_or_create_category
    Category
      .create_with(
        title: title
      )
      .find_or_create_by(
        external_code: category_external_code
      )
  end
end
