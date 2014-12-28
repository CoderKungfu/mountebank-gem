class Mountebank::Stub::ProxyResponse < Mountebank::Stub::Response
  PROXY_MODE_ONCE = 'proxyOnce'
  PROXY_MODE_ALWAYS = 'proxyAlways'

  def self.create(to, mode=PROXY_MODE_ONCE, predicateGenerators=[])
    data = {proxy: {
        to: to,
        mode: mode,
        predicateGenerators: predicateGenerators
      }
    }
    new(data)
  end
end
