require File.expand_path(File.join('..', 'test_helper'), __dir__)

class JobServiceTest < Minitest::Test
  include TestHelpers
  def setup
    @job_params = {
      'category_external_code' => 12332110,
      'partner_id' => '12332111',
      'title' => 'dev',
      'expired_at' => DateTime.now + 10
    }
  end
  def test_intance_job_service
    job_service = JobService.new(@job_params)
    assert_instance_of JobService, job_service
  end

  def test_save_new_job
    JobService.new(@job_params).save
    job = Job.where(partner_id: @job_params['partner_id']).take
    category = Category.where(external_code: @job_params['category_external_code']).take
    assert_equal @job_params['partner_id'], job.partner_id
    assert_equal @job_params['category_external_code'], category.external_code
  end

  def test_retrieve_existent_category
    category = Category.find_or_create_by(title: @job_params['title'], external_code: @job_params['category_external_code'])
    job = JobService.new(@job_params).save
    assert_equal category.id, job.category.id
  end

  def test_not_duplicate_existent_job_by_partner_id
    job = Job.where(partner_id: @job_params['partner_id']).take
    job2 = JobService.new(@job_params).save
    assert_equal job.id, job2.id
  end

  def test_error_not_send_partner_id
    assert_raises ActiveRecord::RecordInvalid do
      JobService.new({}).save
    end
  end
end
