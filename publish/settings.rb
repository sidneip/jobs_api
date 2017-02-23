require 'ostruct'
require 'yaml'
all_config = YAML.load_file(File.join(__dir__, 'config.yml')) || {}
env = ENV['ENV_APP'] || 'development'
env_config = all_config[env] || {}
AppConfig = OpenStruct.new(env_config)
