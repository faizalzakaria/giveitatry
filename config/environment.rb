# Load the rails application
require File.expand_path('../application', __FILE__)
require 'uri_validator'

# Initialize the rails application
Giveitatry::Application.initialize!
Giveitatry::Application.config.limit_per_room = 10
