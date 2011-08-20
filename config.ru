$: << File.dirname(__FILE__) + '/lib' unless $:.include? File.dirname(__FILE__) + '/lib'

require 'rubygems'
require 'active_record'
require 'pg'
require 'redis'
require 'redis/objects'
require 'sinatra'
require 'haml'
require 'appname/appname'

# set working directory
working = File.expand_path File.dirname(__FILE__)
set :root, working

# set haml to html5 mode, disable sinatra from autostart
set :haml, :format => :html5
disable :run, :reload

# redirect logs
log = File.new(File.join(working, 'run', 'sinatra.log'), 'a')
$stdout.reopen(log)
$stderr.reopen(log)

# establish database connection
ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'dbname',
  :encoding => 'utf8',
  :host => 'localhost',
  :username => 'dbuser',
  :password => ''
)

# establish redis connection
Redis::Objects.redis = Redis.new(:host => '127.0.0.1', :port => 6379)

# load core class and run
run AppName::Application
