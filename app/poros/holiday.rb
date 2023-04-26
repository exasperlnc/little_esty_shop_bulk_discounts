class Holiday
  attr_reader :date, :localname, :name
  def initialize(data)
    @date = data[:date]
    @localname = data[:localName]
    @name = data[:name]
  end
end