# Load coto_solutions plugin
plugin_path = Rails.root.join('vendor', 'plugins', 'coto_solutions', 'lib')
$LOAD_PATH.unshift(plugin_path) unless $LOAD_PATH.include?(plugin_path)

# Load the helper
require Rails.root.join('vendor', 'plugins', 'coto_solutions', 'app', 'helpers', 'coto_helper')

# Load the main plugin
require 'coto_solutions'
