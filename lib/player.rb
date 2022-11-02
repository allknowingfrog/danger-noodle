class Player
  DIRS = {
    "up" => {"x" => 0, "y" => 1},
    "down" => {"x" => 0, "y" => -1},
    "left" => {"x" => -1, "y" => 0},
    "right" => {"x" => 1, "y" => 0}
  }

  class << self
    def move(data)
      height = data["board"]["height"]
      width = data["board"]["height"]

      bodies = data["board"]["snakes"].flat_map { |s| s["body"] }

      head = data["you"]["head"]

      options = valid_moves(height, width, bodies, head)
      preferences = favorite_moves(height, width, head)

      (preferences & options).first
    end

    private

    def valid_moves(height, width, bodies, head)
      DIRS.map do |dir, move|
        candidate = head.dup

        candidate["x"] += move["x"]
        candidate["y"] += move["y"]

        next if candidate["x"] < 0
        next if candidate["x"] >= width
        next if candidate["y"] < 0
        next if candidate["y"] >= height

        next if bodies.any? do |body|
          candidate["x"] == body["x"] && candidate["y"] == body["y"]
        end

        dir
      end.compact
    end

    def favorite_moves(height, width, head)
      target_x = width / 2.0
      target_y = height / 2.0

      xx = target_x - head["x"]
      yy = target_y - head["y"]

      x_over_y = xx.abs > yy.abs
      left_over_right = xx < 0
      down_over_up = yy < 0

      x_moves = left_over_right ? ["left", "right"] : ["right", "left"]
      y_moves = down_over_up ? ["down", "up"] : ["up", "down"]

      x_over_y ? [x_moves.first, y_moves.first, y_moves.last, x_moves.last] : [y_moves.first, x_moves.first, x_moves.last, y_moves.last]
    end
  end
end
