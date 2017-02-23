require 'byebug'
require 'job'
class Test
	path = '/Users/sidnei/projects/empregoligado/publish/jobs.txt'
	jobs = CSV.read(path, {:col_sep => '|', headers: true})
	jobs.each do |job|
		Job.new(
			title: job['title'], 
			category_external_code: job['categoryId'],
			expired_at: job['ExpiresAt'],
			partner_id: job['partnerId']
		).save
	end
end