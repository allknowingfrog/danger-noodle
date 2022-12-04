require_relative "./board"
require_relative "./snake"
require_relative "./move"

class Player
  class << self
    def move(data)
      board = Board.parse(data["board"])

      head = Snake.parse(data["you"]).head

      Move.permutate(head)
        .select { |move| board.passable?(move.location) }
        .select { |move| board.safe?(move.location) }
        .min_by { |move| move.location.pythagorean_distance(board.center) }
        .dir
    end

    def move_towards(board, location, target)
      moves = []

      edges = Move.permutate(location, target)
        .select { |move| board.passable?(move.location) }

      while edges.any?
        target = edges.find { |e| e.location == target }

        break if target

        moves += edges

        edges = moves.min_by(&:cost).expand(target, moves)
          .reject { |move| moves.include?(move) }
          .select { |move| board.passable?(move.location) }
      end
    end
  end
end
