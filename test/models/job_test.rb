require File.expand_path(File.join('..', 'test_helper'), __dir__)

class JobTest < Minitest::Test
  def test_instance_job
    job = Job.new
    assert_instance_of Job, job
  end
end
