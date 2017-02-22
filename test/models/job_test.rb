require File.expand_path(File.join('..', 'test_helper'), __dir__)

class JobTest < Minitest::Test
  def setup
    @category = Category.create(title: 'Test', external_code: 123456)
  end

  def test_instance_job
    job = Job.new
    assert_instance_of Job, job
  end

  def test_create_valid_job
    Job.create(category_id: @category.id, expired_at: DateTime.now, partner_id: 123456)
    job = Job.where(partner_id: 123456).take
    assert job
  end
end
