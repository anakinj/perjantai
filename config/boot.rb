ENV['RACK_ENV'] ||= 'test'

APP_ROOT ||= File.expand_path('../..', __FILE__)

Bundler.require(:default, ENV['RACK_ENV'])

require_relative '../lib/perjantai/commands/create_lottery'
require_relative '../lib/perjantai/events/lottery_created'
require_relative '../lib/perjantai/models/lottery'
require_relative '../lib/perjantai/event_chain'
require_relative '../lib/perjantai/materializer'
require_relative '../api/api'
require_relative '../app/app'
