class Location
  DIRS = {
    "up" => [0, 1],
    "down" => [0, -1],
    "right" => [1, 0],
    "left" => [-1, 0]
  }

  attr_reader :x, :y

  def initialize(x:, y:)
    @x = x
    @y = y
  end

  def self.parse(data)
    new(x: data["x"], y: data["y"])
  end

  def neighbors
    DIRS.values.map do |dx, dy|
      self.class.new(x: x + dx, y: y + dy)
    end
  end

  def dir(location)
    dx = location.x - x
    dy = location.y - y

    move = [dx, dy]

    DIRS.invert[move]
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
