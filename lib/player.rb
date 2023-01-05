require_relative "./board"
require_relative "./snake"
require_relative "./location"

class Player
  class << self
    def move(data)
      board = Board.parse(data["board"])

      me = Snake.parse(data["you"])
      head = me.head

      options = head.neighbors
        .select { |n| board.passable?(n) }
        .select { |n| board.safe?(n, me) }

      safe_options = options.select { |o| board.untrapped?(o, me) }

      options = safe_options if safe_options.any?

      target = options.min_by do |option|
        if me.health > 50
          option.pythagorean_distance(board.center)
        else
          board.distance_to_food(option)
        end
      end

      head.dir(target)
    end
  end
end
