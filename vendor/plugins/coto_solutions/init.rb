# Include hook code here
require "coto_solutions"
ActionView::Helpers::AssetTagHelper.register_javascript_expansion(
  :path_prefix => "path_prefix"
)