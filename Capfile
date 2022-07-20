require 'capistrano/setup'
set :stage, :production
require 'capistrano/deploy'
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }