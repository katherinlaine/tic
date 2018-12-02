require 'rack/test'
require 'sinatra/base'
require File.expand_path '../../api.rb', __FILE__

module RspecMixin
  include Rack::Test::Methods
  def app() Api end
end

RSpec.configure do |config|
  config.include RspecMixin
end


