require 'sinatra'
require './site.rb'

use Rack::CommonLogger
run Sinatra::Application