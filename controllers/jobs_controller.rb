class JobsApplication < ApplicationController
  get '/' do
    @jobs = Job
             .order(updated_at: :desc)
             .paginate(page: params[:page], per_page: per_page)
    @jobs.to_json
  end

  post '/' do
    begin
      @job_service = JobService.new(job_params).save
      @job_service.to_json
    rescue ActiveRecord::RecordInvalid => e
      status 422
      { error: e }.to_json
    end
  end

  post "/:id/activate" do
    @job = Job.find params["id"]
    @job.activate!
  end

  private
  def job_params
    req_params.slice(
      'category_id',
      'partner_id',
      'expired_at',
      'title',
      'category_external_code',
    )
  end
end
