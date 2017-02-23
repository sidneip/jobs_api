class CategoryServiceTest < Minitest::Test
	include TestHelpers

	def setup
		10.times do |n|
			@job_params = {
	      'category_external_code' => 1332110,
	      'partner_id' => "12332111#{n}",
	      'title' => 'dev',
	      'expired_at' => DateTime.now + 10
	    }
	    JobService.new(@job_params).save
  	end
	end

	def test_instance_servide
		category_service = CategoryService.new(@job_params)
    assert_instance_of CategoryService, category_service
	end

	def test_calculate_actives_percent
		Job.where(id: [1,2,3,4,5]).each(&:activate!)
		id_category = Job.first.category.id
		obj = CategoryService.new(id_category).calculate
		assert_equal 50.0, obj[:percent]
		assert_equal 10, obj[:total]
		assert_equal @job_params['title'], obj[:title]
	end
end