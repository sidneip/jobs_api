require_relative 'settings'
require 'httparty'
require 'active_support/json'

class Job
  include HTTParty

  attr_accessor :title, :category_external_code, :expired_at, :partner_id
  base_uri AppConfig.jobs_api['url']

  def initialize(args = {})
    @title = args.fetch(:title)
    @category_external_code = args.fetch(:category_external_code)
    @expired_at = args.fetch(:expired_at)
    @partner_id = args.fetch(:partner_id)
  end

  def to_json
    ActiveSupport::JSON.encode(self)
  end

  def save
    self.class.post('/jobs', body: self.to_json, headers: { 'Content-Type' => 'application/json' })
  end
end
