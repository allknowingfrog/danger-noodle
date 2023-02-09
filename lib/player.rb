require_relative "./board"
require_relative "./snake"
require_relative "./location"

class Player
  class << self
    def move(data)
      board = Board.parse(data["board"])

      me = Snake.parse(data["you"])
      head = me.head

      options = head.neighbors.select { |n| board.passable?(n) }

      safe_options = options.select { |n| board.safe?(n, me) }

      untrapped_options = safe_options.select { |o| board.untrapped?(o, me) }

      amazing_options = untrapped_options.select { |o| board.safe_diagonals?(o, me) }

      spectacular_options = amazing_options.select { |o| board.flood_to?(o, me, 5) }

      target = [spectacular_options, amazing_options, untrapped_options, safe_options, options]
        .find(&:any?)
        .min_by do |option|
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
