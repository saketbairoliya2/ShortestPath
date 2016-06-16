require 'priority_queue'
 
class Graph
    def initialize()
        @vertices = {}
    end
  
    def add_vertex(name, edges)
        @vertices[name] = edges
    end
    
    def shortest_path(start, finish)
        maxint = (2**(0.size * 8 -2) -1)
        distances = {}
        previous = {}
        nodes = PriorityQueue.new
        
        @vertices.each do | vertex, value |
            if vertex == start
                distances[vertex] = 0
                nodes[vertex] = 0
            else
                distances[vertex] = maxint
                nodes[vertex] = maxint
            end
            previous[vertex] = nil
        end
        
        while nodes
            smallest = nodes.delete_min_return_key
            
            if smallest == finish
                path = []
                while previous[smallest]
                    path.push(smallest)
                    smallest = previous[smallest]
                end
                #return path
                path.each do |name|
                    puts name
                end
            end
            
            if smallest == nil or distances[smallest] == maxint
                break            
            end
            
            @vertices[smallest].each do | neighbor, value |
                alt = distances[smallest] + @vertices[smallest][neighbor]
                if alt < distances[neighbor]
                    distances[neighbor] = alt
                    previous[neighbor] = smallest
                    nodes[neighbor] = alt
                end
            end
        end
        puts distances[finish]
        #return distances.inspect
    end
    
    def to_s
        #return @vertices.inspect
        puts @vertices
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