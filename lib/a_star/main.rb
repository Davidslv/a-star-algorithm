module AStar
  class Main
    def initialize(start, goal)
      [start, goal].each do |input|
        raise ArgumentError,
          "Required a Node as input." +
          "Received a #{input.class}" unless input.is_a? Node
      end

      # start and goal node
      @start, @goal = start, goal

      # The open set is is the first set that contains all
      # the nodes that we have not explored yet.
      # It is initialized with only the starting node.
      @openset = [@start]

      # The closed set is the second set that contains all
      # the nodes that already been explored and are in our
      # path or are failing strategy
      @closedset = []

      # It evaluates the distance between the start and ending point
      @start.h = @start.distance(@goal)
    end

    def search
      improving = nil

      # The search will continue until @openset has no more Nodes
      until @openset.empty? do
        # The next node is the one that has the minimum distance
        # from the origin and the minimum distance from the exit.
        # This it should have the minimum value of f.
        current_node = find_node_with_min_f

        # if the next node selected is the stop node
        # we got to the goal
        if current_node == @goal
          # And we can return the path by reconstructing it
          # recursively backwards.
          return reconstructed_path(current_node)
        end

        # We are now inspecting the next node.
        # We have to remove it from the openset
        # and to add it to the closedset.
        @openset -= [current_node]
        @closedset += [current_node]

        current_node.next_nodes.each do |next_node|
          # move to the next node if we have already visited the next node
          next if @closedset.include?(next_node)

          # calculate distance between both nodes
          g_score = current_node.g + current_node.distance(next_node)

          # There are three condition to consider
          #  1. next_node is not in the openset.
          #     this is always an improvement
          #  2. next_node is in the openset, but its g_score is lower
          #     this means we have found a better strategy to reach next_node
          #  3. next_node already has a better g_score,
          #     or in any case this strategy is not an improvement
          if !@openset.include?(next_node)
            @openset += [next_node]
            improving = true
          elsif g_score < next_node.g
            improving = true
          else
            improving = false
          end

          if improving
            next_node.previous_node = current_node
            next_node.g = g_score
            next_node.h = next_node.distance(@goal)
          end
        end
      end # until loop

      return []
    end

    # Searches the node with the minimum f in the openset
    def find_node_with_min_f
      next_node = @openset.first

      for i in 1...@openset.size
        next_node = @openset[i] if next_node.f > @openset[i].f
      end

      return next_node
    end

    # It reconstructs the path by using a recursive function
    # that runs from the last node till the beginning.
    # It is stopped when the analyzed node has no previous node
    def reconstructed_path(current_node)
      return [] unless current_node.previous_node

      reconstructed_path(current_node.previous_node) + [current_node]
    end
  end
end
