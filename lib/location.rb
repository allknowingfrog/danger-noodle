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

  def pythagorean_distance(location)
    a = (location.x - x).abs
    b = (location.y - y).abs

    Math.sqrt(a**2 + b**2)
  end

  def ==(other)
    other.x == x && other.y == y
  end
end
