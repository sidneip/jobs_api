require File.expand_path(File.join('..', 'test_helper'), __dir__)

class CategoryTest < Minitest::Test
  def test_instance_category
    category = Category.new
    assert_instance_of Category, category
  end

  def test_create_valid_category
    category = Category.new(title: 'teste', external_code: '1212')
    assert category.valid?
  end

  def test_save_new_category
    Category.create(title: 'teste', external_code: '091202')
    assert Category.where(external_code: '091202').take
  end

  def test_show_error_duplicate_category_by_external_code
    category = Category.create(title: 'teste', external_code: '0909')
    category2 = Category.new(title: 'teste', external_code: '0909')
    category2.valid?
    assert category2.errors.messages[:external_code].include?("has already been taken")
  end

  def test_not_valid_because_external_id_duplicate
    assert_raises ActiveRecord::RecordInvalid do
      2.times do |t|
        Category.create!(title: 'teste', external_code: '1010')
      end
    end
  end
end
