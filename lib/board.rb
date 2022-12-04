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

  def safe?(location)
    # one of these snakes is me; two or more could be a problem
    snakes.one? do |snake|
      location.distance(snake.head) == 1
    end
  end

  private

  def obstacles
    @obstacles ||= snakes.flat_map(&:body) + hazards
  end
end
