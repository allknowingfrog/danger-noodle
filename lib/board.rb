require_relative "./location"
require_relative "./snake"

class Board
  attr_reader :height, :width, :food, :hazards, :snakes

  def initialize(height:, width:, food: [], hazards: [], snakes: [])
    @height = height
    @width = width
    @food = food
    @hazards = hazards
    @snakes = snakes
  end

  def self.parse(data)
    new(
      height: data["height"],
      width: data["width"],
      food: data["food"].map { |f| Location.parse(f) },
      hazards: data["hazards"].map { |h| Location.parse(h) },
      snakes: data["snakes"].map { |s| Snake.parse(s) }
    )
  end

  def center
    Location.new(x: width / 2, y: height / 2)
  end

  def passable?(location)
    contains?(location) && !obstacle?(location)
  end

  def obstacle?(location)
    obstacles.include?(location)
  end

  def contains?(location)
    location.x >= 0 && location.x < width && location.y >= 0 && location.y < height
  end

  def other_snakes(me)
    snakes.reject { |s| s.head == me.head }
  end

  def safe?(location, me)
    other_snakes(me).none? do |snake|
      location.distance(snake.head) == 1 && snake.length >= me.length
    end
  end

  def untrapped?(location, me)
    location.neighbors
      .select { |n| passable?(n) }
      .any? do |neighbor|
        neighbor.neighbors.count { |n| passable?(n) && safe?(n, me) } > 1
      end
  end

  def distance_to_food(location)
    food.map { |f| location.distance(f) }.min
  end

  private

  def obstacles
    @obstacles ||= snakes.flat_map(&:body) + hazards
  end
end
