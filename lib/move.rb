require_relative "./location"

class Move
  DIRS = {
    "up" => [0, 1],
    "down" => [0, -1],
    "right" => [1, 0],
    "left" => [-1, 0]
  }

  attr_reader :dir, :location, :source, :steps, :target

  def initialize(dir:, location:, source:, steps:, target:)
    @dir = dir
    @location = location
    @source = source
    @steps = steps
    @target = target
  end

  def cost
    steps + location.distance(target)
  end

  def expand(target)
    self.class.map(location) do |dir, neighbor|
      self.class.new(
        location: neighbor,
        source: location,
        steps: steps + 1,
        target: target
      )
    end
  end

  def ==(other)
    location == other.location
  end

  def self.map(location)
    DIRS.map do |dir, (dx, dy)|
      yield dir, Location.new(x: location.x + dx, y: location.y + dy)
    end
  end

  def self.permutate(location, target = nil)
    map(location) do |dir, neighbor|
      new(dir: dir, location: neighbor, source: location, steps: 1, target: target)
    end
  end
end
