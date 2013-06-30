# Load the rails application
require File.expand_path('../application', __FILE__)

# Load my libraries.
require Pathname(Rails.root) + 'lib/tweet'

# Initialize the rails application
Tweeter::Application.initialize!
