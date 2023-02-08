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

      final_options = [amazing_options, untrapped_options, safe_options, options].find(&:any?)

      openness_scores = final_options.map do |location|
        [location, board.openness(location, me)]
      end

      best_score = openness_scores.map(&:last).max

      open_options = openness_scores.select { |l, s| s == best_score }.map(&:first)

      target = open_options.min_by do |option|
        if me.health > 60
          option.pythagorean_distance(board.center)
        else
          board.distance_to_food(option)
        end
      end

      head.dir(target)
    end
  end
end
