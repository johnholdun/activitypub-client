class Route
  TEMPLATES = {}

  def call(env)
    @env = env
    resolve
  end

  private

  attr_reader :env

  def resolve
    raise NotImplementedError
  end

  def auth_request
    Rack::Auth::Basic::Request.new(env)
   end

  def request
    Rack::Request.new(env)
  end

  def request_method
    (params['_method'] || request.request_method).to_s.upcase
  end

  def params
    request.params
  end

  def router_params
    env['router.params']
  end

  def render(template_name, locals = {})
    template(:layout).render \
      binding,
      title: locals[:title],
      content:
        template(template_name)
          .render(Object.new, locals)
  end

  def finish_html(body, status: 200, headers: {})
    headers['Content-Type'] ||= 'text/html'
    [status, headers, [body]]
  end

  def template(name)
    TEMPLATES[name.to_sym] ||=
      Haml::Engine
        .new(File.read("views/#{name}.haml"))
  end
end
