require File.expand_path(File.join('..', 'test_helper'), __dir__)
class JobsControllerTest < Minitest::Test
  include TestHelpers

  include Rack::Test::Methods

  def setup
    create_multiple_jobs(11)
  end

  def app
    JobsApplication
  end

  def test_index_status_200
    get '/'
    assert last_response.ok?
  end

  def test_index_list_jobs
    body = get_json('/')
    assert_equal 10, body.size
  end

  def test_get_page_2
    body = get_json('/?page=2')
    assert_equal 1, body.size
  end

  def test_job_attributes
    body = get_json('/')
    ['partner_id', 'category_id', 'expired_at', 'status'].each do |field|
      body[0].keys.include?(field)
    end
  end
end
