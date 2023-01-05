require_relative "./board"
require_relative "./snake"
require_relative "./location"

class Player
  class << self
    def move(data)
      board = Board.parse(data["board"])

      me = Snake.parse(data["you"])
      head = me.head

      targets = head.neighbors
        .select { |n| board.passable?(n) }
        .select { |n| board.safe?(n, me) }

      safe_targets = targets.select { |n| board.untrapped?(n, me) }

      targets = safe_targets if safe_targets.any?

      target = targets.min_by do |neighbor|
        if me.health > 50
          neighbor.pythagorean_distance(board.center)
        else
          board.distance_to_food(neighbor)
        end
      end

      head.dir(target)
    end
  end
end
