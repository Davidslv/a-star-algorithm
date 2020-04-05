module AStar
  class Node
    attr_accessor :g, :h, :previous_node
    attr_reader :x, :y, :next_nodes

    ##
    # The Node class contains everything that is necessary to describe
    # a complete graph.
    # The node has a description of the edge to the previous
    # Node (@previous_node)
    # an Array of edges to the next Nodes (@next_nodes).
    #
    # The Node contains also
    #  - @x, @y: indication of the node's position
    #  - @previous_node: the edge to previous position
    #  - @next_nodes: the edges to next positions
    #  - @h: the heuristic distance to the stop node
    #  - @g: the heuristic distance to the start node
    # The total heuristic distance is the sum of (@g + @h)
    def initialize(x, y)
      [x, y].each do |input|
        raise ArgumentError,
        "input must be a Numeric.\n" +
        "Received a #{input.class}" unless input.is_a? Numeric
      end

      @x, @y = x, y

      @h = 0.0
      @g = 0.0

      @previous_node = nil
      @next_nodes = []
    end

    # Add a new edge to a Node in the edges list @next_nodes.
    def <<(node)
      raise ArgumentError,
      "A Node must be given as input.\n" +
      "Received a #{node.class}" unless node.is_a? Node

      @next_nodes << node
    end
    alias_method :insert, :<<

    # Evaluates the distance of the current node with another node
    def distance(node)
      raise ArgumentError,
      "A Node must be given as input.\n" +
      "Received a #{node.class}" unless node.is_a? Node

      (
        (@x - node.x) ** 2 +
        (@y - node.y) ** 2
      ) ** 0.5
    end

    # Heuristic total distance
    def f
      @g + @h
    end
  end
end
