require 'priority_queue'
class Graph < City
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
		dist_path = {} # To keep the path and the distance from src to dest.
		nodes =  PriorityQueue.new

		#puts "Here goes the src of Paths #{dest}"

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
				path.push(src)
				path.reverse!
				path.each do |name|
					puts name
				end
				dist_path['path_src_dest'] = path
				dist_path['dist_src_dest'] = distance[dest]
				return dist_path
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

		#puts @cities
		#puts "Distance from source to dest is #{distance[dest]}"
	end
end


