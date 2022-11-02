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

      valid_moves(height, width, bodies, head).sample
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
  end
end
