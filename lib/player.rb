require_relative "./board"
require_relative "./snake"
require_relative "./location"

class Player
  class << self
    def move(data)
      board = Board.parse(data["board"])

      me = Snake.parse(data["you"])
      head = me.head

      options = head.neighbors.group_by { |n| board.flood_limit(n, me) }

      highest = options.keys.max

      most_centered = options[highest].min_by do |option|
        option.pythagorean_distance(board.center)
      end

      target =
        if me.health > 50
          most_centered
        else
          keys = options.keys.select { |k| k > 6 }

          if keys.any?
            options.fetch_values(*keys).flatten.min_by do |option|
              board.distance_to_food(option)
            end
          else
            most_centered
          end
        end

      head.dir(target)
    end
  end
end
