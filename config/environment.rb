# Load the rails application
require File.expand_path('../application', __FILE__)

# Load my libraries.
require Pathname(Rails.root) + 'lib/tweet'

# Load general settings.
CONFIG = YAML.load_file(Pathname(Rails.root) + "config/settings.yml")

# Initialize the rails application
Tweeter::Application.initialize!
