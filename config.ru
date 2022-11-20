require "dotenv/load" if ENV["DOTENV"]
require "amygdala"

require "./lib/player"

Amygdala.set_configs({
  apiversion: "1",
  author: ENV.fetch("AUTHOR"),
  color: ENV.fetch("COLOR"),
  head: ENV.fetch("HEAD"),
  tail: ENV.fetch("TAIL"),
  version: ENV.fetch("VERSION")
})

Amygdala.set_move_handler(Player.method(:move))

run Amygdala::Server
