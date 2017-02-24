require File.expand_path(File.join('..', 'test_helper'), __dir__)
class JobsControllerTest < Minitest::Test

  include Rack::Test::Methods

  def app
    JobsApplication
  end

  def test_index_status_200
    get '/'
    assert last_response.ok?
  end
end
