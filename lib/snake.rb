require_relative "./location"

class Snake
  attr_reader :id, :name, :health, :body, :latency, :head, :length, :shout, :customizations

  def initialize(id:, name:, health:, body:, latency:, head:, length:, shout:, customizations:)
    @id = id
    @name = name
    @health = health
    @body = body
    @latency = latency
    @head = head
    @length = length
    @shout = shout
    @customizations = customizations
  end

  def self.parse(data)
    new(
      id: data["id"],
      name: data["name"],
      health: data["health"],
      body: data["body"].map { |b| Location.parse(b) },
      latency: data["latency"],
      head: Location.parse(data["head"]),
      length: data["length"],
      shout: data["shout"],
      customizations: data["customizations"]
    )
  end
end
