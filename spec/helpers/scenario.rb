class Scenario
  class << self
    def generate(scenario, health: {})
      rows = scenario.split("\n").reverse

      snakes = {}
      food = []

      uppers = ("A".."Z")
      lowers = ("a".."z")

      rows.each_with_index do |row, y|
        row.chars.each_with_index do |char, x|
          location = {"x" => x, "y" => y}

          case char
          when "*"
            food << location
          when uppers
            snakes[char] ||= []
            snakes[char].prepend(location)
          when lowers
            key = char.upcase
            snakes[key] ||= []
            snakes[key] << location
          end
        end
      end

      {
        "game" => {
          "id" => "totally-unique-game-id",
          "ruleset" => {
            "name" => "standard",
            "version" => "v1.1.15",
            "settings" => {
              "foodSpawnChance" => 15,
              "minimumFood" => 1,
              "hazardDamagePerTurn" => 14
            }
          },
          "map" => "standard",
          "source" => "league",
          "timeout" => 500
        },
        "turn" => 14,
        "board" => generate_board(snakes: snakes.sort.to_h, health: health, food: food, size: rows.count)
      }.tap do |data|
        data["you"] = data["board"]["snakes"].first
      end
    end

    private

    def generate_board(snakes: nil, health: {}, food: nil, size: 11)
      food ||= [
        {"x" => 5, "y" => 5},
        {"x" => 9, "y" => 0},
        {"x" => 2, "y" => 6}
      ]

      {
        "height" => size,
        "width" => size,
        "food" => food,
        "hazards" => [],
        "snakes" => []
      }.tap do |board|
        snakes ||= {
          "A" => [
            {"x" => 0, "y" => 0},
            {"x" => 1, "y" => 0},
            {"x" => 2, "y" => 0}
          ],
          "B" => [
            {"x" => 5, "y" => 4},
            {"x" => 5, "y" => 3},
            {"x" => 6, "y" => 3},
            {"x" => 6, "y" => 2}
          ]
        }

        snakes.each do |name, body|
          board["snakes"] << {
            "id" => "snake-508e96a#{name.downcase}-94ad-11ea-bb37",
            "name" => "Snake #{name}",
            "health" => health[name] || 50,
            "body" => body,
            "latency" => "123",
            "head" => body.first,
            "length" => body.size,
            "shout" => "",
            "customizations" => {
              "color" => "#000000",
              "head" => "default",
              "tail" => "default"
            }
          }
        end
      end
    end
  end
end
