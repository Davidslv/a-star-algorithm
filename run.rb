#!/usr/bin/env ruby

require_relative 'lib/a_star'

minimap = File.open("./fixtures/minimap.txt", "r").read
map = File.open("./fixtures/map.txt", "r").read
impossible = File.open("./fixtures/impossible.txt", "r").read

map_titles = %w(minimap map impossible)
maps = [minimap, map, impossible]

maps.each_with_index do |m, index|
  puts ""
  puts map_titles[index]
  puts ""
  graph = AStar::Graph.new(m)
  algo = AStar::Main.new(graph.start, graph.stop)
  path = algo.search


  puts graph.to_s(path)
  puts ""
end



exit 0
