require "sinatra/base"
require "sinatra/activerecord"
require "json"

require 'will_paginate'
require 'will_paginate/active_record'

class JobsApplication < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  set :method_override, true

  before do
    content_type :json
  end

end
