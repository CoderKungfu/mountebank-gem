class Mountebank::Stub::Response
  attr_accessor :is, :proxy, :inject

  def initialize(data={})
    @is = data[:is] || nil
    @proxy = data[:proxy] || nil
    @inject = data[:inject] || nil
    @behaviors = data[:_behaviors]
  end

  def self.with_injection(injection='')
    return false if injection.empty?

    data = {inject:injection}
    new(data)
  end

  def to_json(*args)
    data = {}
    data[:is] = @is unless @is.nil?
    data[:proxy] = @proxy unless @proxy.nil?
    data[:inject] = @inject unless @inject.nil?
    data[:_behaviors] = @behaviors unless @behaviors.nil?
    data.to_json(*args)
  end
end
