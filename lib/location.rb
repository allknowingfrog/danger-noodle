class Location
  attr_reader :x, :y

  def initialize(x:, y:)
    @x = x
    @y = y
  end

  def self.parse(data)
    new(x: data["x"], y: data["y"])
  end

  def distance(location)
    (location.x - x).abs + (location.y - y).abs
  end

  def ==(other)
    other.x == x && other.y == y
  end
end
