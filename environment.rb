require 'bundler'

Bundler.require

Dir.glob('./lib/*.rb').each { |f| require(f) }
Dir.glob('./routes/*.rb').each { |f| require(f) }

DB = Sequel.connect('sqlite://data.db')
