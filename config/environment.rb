# Load the Rails application.
require_relative 'application'

# Load my libraries.
require Pathname(Rails.root) + 'lib/tweet'

# Load general settings.
CONFIG = YAML.load_file(Pathname(Rails.root) + "config/settings.yml")
DEFAULT_SHOP_ID = 1

# Initialize the Rails application.
Rails.application.initialize!
