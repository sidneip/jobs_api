require File.expand_path(File.join('..', 'test_helper'), __dir__)

class CategoriesControllerTest < Minitest::Test
  def setup
    @category = Category.create(title: 'dev', external_code: 919821)
  end

  include Rack::Test::Methods

  def app
    CategoriesController
  end

  def test_index_status_200
    get "/#{@category.id}"
    assert_equal 403, last_response.status
  end
end
