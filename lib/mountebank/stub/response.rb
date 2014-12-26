class Mountebank::Stub::Response
  attr_accessor :is, :proxy, :inject

  def initialize(data={})
    @is = data[:is] || nil
    @proxy = data[:proxy] || nil
    @inject = data[:inject] || nil
  end

  def to_json(*args)
    data = {}
    data[:is] = @is unless @is.nil?
    data[:proxy] = @proxy unless @proxy.nil?
    data[:inject] = @inject unless @inject.nil?
    data.to_json(*args)
  end
end
