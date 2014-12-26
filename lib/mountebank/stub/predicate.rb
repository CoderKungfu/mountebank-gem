class Mountebank::Stub::Predicate
  attr_accessor :equals, :deepEquals, :contains, :startsWith, :endsWith, :matches, :exists, :not, :or, :and, :inject, :caseSensitive, :except

  VALID_OPERATORS = [
    :equals, :deepEquals, :contains, :startsWith, :endsWith, :matches, :exists, :not,
    :or, :and, :inject
  ]

  def initialize(data={})
    VALID_OPERATORS.each do |key|
      send("#{key}=", data[key]) if data.key?(key)
    end
    @caseSensitive = data[:caseSensitive] || nil
    @except = data[:except] || nil
  end

  def to_json(*args)
    data = {}
    VALID_OPERATORS.each do |key|
      data[key] = send("#{key}") if instance_variable_defined?("@#{key}")
    end
    data[:caseSensitive] = @caseSensitive unless @caseSensitive.nil?
    data[:except] = @except unless @except.nil?
    data.to_json(*args)
  end
end
