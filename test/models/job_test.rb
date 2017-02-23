require File.expand_path(File.join('..', 'test_helper'), __dir__)

class JobTest < Minitest::Test
  include TestHelpers
  def setup
    @category = Category.find_or_create_by(title: 'Test', external_code: 123456)
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

  def test_error_create_job_expired
    job = Job.create(category_id: @category.id, expired_at: DateTime.now - 1.day, partner_id: 1234189)
    job.valid?
    assert_equal("job expired", job.errors.messages[:expired_at][0])
  end

  def test_save_invalid_job
    assert_raises ActiveRecord::RecordInvalid do
      2.times do |t|
        job = Job.create!(category_id: @category.id, expired_at: DateTime.now - 1.day, partner_id: 123456)
      end
    end
  end

  def test_new_job_default_status_draft
    job = Job.create(category_id: @category.id, expired_at: DateTime.now + 1.day, partner_id: 9988)
    assert_equal 'draft', job.status
  end

  def test_activate_job
    job_new = Job.create(category_id: @category.id, expired_at: DateTime.now + 1.day, partner_id: 991210)
    job_new.save
    job_new.activate!
    assert_equal 'active', job_new.reload.status
  end

  def test_partner_id_is_unique
    job = Job.create(category_id: @category.id, expired_at: DateTime.now + 1.day, partner_id: 1234189)
    job2 = Job.create(category_id: @category.id, expired_at: DateTime.now + 1.day, partner_id: 1234189)
    job2.valid?
    assert_equal("has already been taken", job2.errors.messages[:partner_id][0])
  end
end
