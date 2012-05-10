# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Dreambop3::Application.initialize!
#gem "aws-s3", "0.5.1", :require_as => "aws/s3"
#gem "shipping"
gem 'will_paginate'
#gem 'rmagick', :require_as => 'RMagick'
gem "aws-s3", :require_as => "aws/s3"
gem 'memcache-client'
gem 'cached_model'
gem 'mysql2'
#gem 'mysql'
gem 'active_shipping'

REST_AUTH_SITE_KEY         = 'c61ffc0052fd2935baaf9d71e9aR87932278a31b'
