require 'priority_queue'
class Graph
	def initialize()
		@vertices = {}
	end

	def add_vertex(name, edges)
		@vertices[name] = edges
	end

	def shortest_path(src, dest)
		maxint = (2**(0.size * 8 - 1) - 1) #To get the Maximum value. of integer type.
		distance = {} #To store the distance of vertex from src node.
		previous = {} #To keep the mark on the previous node in the tree.
		nodes =  PriorityQueue.new

		@vertices.each do |vertex, value|
			if vertex == src
				distance[vertex] = 0
				nodes[vertex] = 0
			else
				distance[vertex] = maxint
				nodes[vertex] = maxint
			end
			previous[vertex] = nil
		end

		# Loop through the priority Queue heap till it's available(Basically loop till all the nodes are covered)
		while nodes
			smallest = nodes.delete_min_return_key

			#This is to get the path of the src to dest node.
			if smallest == dest
				path = []
				while previous[smallest]
					path.push(smallest)
					smallest = previous[smallest]
				end
				#return path
				puts "Inside "
				path.each do |name|
					puts name
				end
			end

			# To handle the error in case the Priority Queue Heap is not Correct.
			if smallest == nil or distance[smallest] == maxint
				break
			end

			@vertices[smallest].each do |neighbor, value|
				# neighbor => value of linked Node too smallest, value => Value of the neighbor node.
				temp = distance[smallest] + @vertices[smallest][neighbor]
				if temp < distance[neighbor]
					distance[neighbor] = temp
					previous[neighbor] = smallest
					nodes[neighbor] = temp
				end
			end
		end

		puts "Distance from source to dest is #{distance[dest]}"
		return distance.inspect
	end
end

g = Graph.new
g.add_vertex('Bangalore', {'Belgaum' => 24, 'Mysore' => 71})
g.add_vertex('Mysore', {'Mandya' => 101, 'Mangalore' => 169, 'Tumkur' => 134})
g.add_vertex('Mandya', {'Tumkur' => 65.5, 'Mangalore' => 141, 'Mysore' => 101})
g.add_vertex('Mangalore', {'Mandya' => 141, 'Mysore' => 169})
g.add_vertex('Tumkur', {'Mandya' => 65.5, 'Mysore' => 134, 'Belgaum' => 59})
g.add_vertex('Belgaum', {'Bangalore' => 24, 'Chickmagalur' => 103, 'Tumkur' => 59})
g.add_vertex('Chickmagalur', {'Belgaum' => 103})
puts g.shortest_path('Mangalore', 'Chickmagalur');


