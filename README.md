# A-Star Algorithm

### Introduction

A ruby implementation

Originally written by [Matteo Ragni](https://github.com/MatteoRagni/ruby-astar).

I'm simply learning from his code and make my own personal notes and
changing the code for my own understanding.

This is educational material.

### I want to see the output

```
▶ ./run
```


### How to use the nodes

```sh
▶ irb -r ./lib/a_star
irb(main):001:0> AStar::Node
=> AStar::Node
```

```ruby

 node1 = AStar::Node.new(0,0)
 node2 = AStar::Node.new(1,2)
 node3 = AStar::Node.new(1,1)


 node1 << node2
 node2.previous_node = node1
 node2 << node3
 node3.previous_node = node1

 node1.distance(node3)

```
