#!/usr/bin/env ruby

require_relative 'lib/a_star'

minimap = File.open("./fixtures/minimap.txt", "r").read
map = File.open("./fixtures/map.txt", "r").read

[minimap, map].each_with_index do |m, index|
  puts ""
  puts index.zero? ? "Minimap" : " Map "
  puts ""
  graph = AStar::Graph.new(m)
  algo = AStar::Main.new(graph.start, graph.stop)
  path = algo.search


  puts graph.to_s(path)
  puts ""
end



exit 0
