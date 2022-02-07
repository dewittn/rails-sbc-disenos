class PathPrefix
  # :api: private
  def initialize(app, path_prefix = nil)
    @app = app
    @path_prefix = /^#{Regexp.escape(path_prefix)}/
  end
  
  # :api: plugin
  def deferred?(env)
    strip_path_prefix(env) 
    @app.deferred?(env)
  end
  
  # :api: plugin
  def call(env)
    strip_path_prefix(env) 
    # [200, {"Content Type" => "text/html"}, "#{@path_prefix}: #{@key} - #{@key_prefix}"]
    @app.call(env)
  end

  # :api: private
  def strip_path_prefix(env)
    ['PATH_INFO', 'REQUEST_URI'].each do |path_key|
      if env[path_key] =~ @path_prefix
        env[path_key].sub!(@path_prefix, "")
        env[path_key] = "/" if env[path_key].empty?
        @key_prefix = env[path_key]
      end
      @key = env[path_key]
    end
  end
end