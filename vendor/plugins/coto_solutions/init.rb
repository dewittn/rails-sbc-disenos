# Include hook code here
require "coto_solutions"
ActionView::Helpers::AssetTagHelper.register_javascript_expansion(
  :coto_solutions => ["path_prefix"]
)