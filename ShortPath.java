// A Java program for Dijkstra's single source shortest path algorithm.
// The program is for adjacency matrix representation of the graph
import java.util.*;
import java.lang.*;
import java.io.*;
 
class ShortPath
{
    // A utility function to find the vertex with minimum distance value,
    // from the set of vertices not yet included in shortest path tree
    static final int V=7;
    int minDistance(int dist[], Boolean sptSet[])
    {
        // Initialize min value
        int min = Integer.MAX_VALUE, min_index=-1;
 
        for (int v = 0; v < V; v++)
            if (sptSet[v] == false && dist[v] <= min)
            {
                min = dist[v];
                min_index = v;
            }
 
        return min_index;
    }
 
    // A utility function to print the constructed distance array
    void printSolution(int dist[], int path[], int n, int src, int dest, HashMap hm)
    {
        int temp[] = new int[V];// For storing the Path in the reverse(correct order), as I am using stack.
        int count = 0;
        double distance = dist[dest];
        temp[count] = dest;
        count++;
       	while(path[dest] != dest){
       		temp[count] = path[dest];
       		count++;
       		dest = path[dest];
       	}
       	System.out.print("Shortest route and distance: ");
       	for(int i = count-1; i >= 0; i--){
       		int t = temp[i];
       		System.out.print(hm.get(t));
       		if(i != 0)
       			System.out.print("-");
       	}
       	System.out.println(", " + distance + " kms");
       	
    }
 
    // Funtion that implements Dijkstra's single source shortest path
    // algorithm for a graph represented using adjacency matrix
    // representation
    void dijkstra(int graph[][], HashMap hm, int src, int dest)
    {
        int dist[] = new int[V]; // The output array. dist[i] will hold
                                 
        int path[] = new int[V]; // the shortest distance from src to i path.
 
        // sptSet[i] will true if vertex i is included in shortest
        // path tree or shortest distance from src to i is finalized
        Boolean sptSet[] = new Boolean[V];
 
        // Initialize all distances as INFINITE and stpSet[] as false
        for (int i = 0; i < V; i++)
        {
            dist[i] = Integer.MAX_VALUE;
            sptSet[i] = false;
        }
 
        // Distance of source vertex from itself is always 0
        dist[src] = 0;
        path[src] = src;
 
        // Find shortest path for all vertices
        for (int count = 0; count < V-1; count++)
        {
            // Pick the minimum distance vertex from the set of vertices
            // not yet processed. u is always equal to src in first
            // iteration.
            int u = minDistance(dist, sptSet);
            if(u == dest)break; // If the Destination is reached, break the for loop.
 
            // Mark the picked vertex as processed
            sptSet[u] = true;
 
            // Update dist value of the adjacent vertices of the
            // picked vertex.
            for (int v = 0; v < V; v++)
 
                // Update dist[v] only if is not in sptSet, there is an
                // edge from u to v, and total weight of path from src to
                // v through u is smaller than current value of dist[v]
                if (!sptSet[v] && graph[u][v]!=0 &&
                        dist[u] != Integer.MAX_VALUE &&
                        dist[u]+graph[u][v] < dist[v]){
                    dist[v] = dist[u] + graph[u][v];
                	path[v] = u;
                }
        }
 
        // print the constructed distance array
        printSolution(dist, path, V, src, dest, hm);
    }
 
    // Driver method
    public static void main (String[] args)
    {
        /* Let us create the example graph discussed above */
       int graph[][] = new int[][]{
       							  {0, 71, 0, 0, 0, 24, 0},
                                  {0, 0, 101, 169, 134, 0, 0},
                                  {0, 101, 0, 141, 65, 0, 0},
                                  {0, 169, 141, 0, 0, 0, 0},
                                  {0, 134, 65, 0, 0, 59, 0},
                                  {24, 0, 0, 0, 59, 0, 103},
                                  {0, 0, 0, 0, 0, 103, 0}
                                 };
        int src_num = -1, dest_num = -1;
        ShortPath t = new ShortPath();
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter Name of the city from the following List");
        System.out.println("Bangalore");
        System.out.println("Mysore");
        System.out.println("Mandya");
        System.out.println("Mangalore");
        System.out.println("Tumkur");
        System.out.println("Belgaum");
        System.out.println("Chickmagalur\n\n");

        System.out.println("Enter city #1: ");
        String src = sc.next();
        System.out.println("Enter city #2: ");
        String dest = sc.next();
        HashMap hm = new HashMap();
        hm.put(0, "Bangalore");
        hm.put(1, "Mysore");
        hm.put(2, "Mandya");
        hm.put(3, "Mangalore");
        hm.put(4, "Tumkur");
        hm.put(5, "Belgaum");
        hm.put(6, "Chickmagalur");
        Set set = hm.entrySet();
        Iterator i = set.iterator();
        while(i.hasNext()){
        	Map.Entry me = (Map.Entry)i.next();
        	String str = me.getValue().toString();
        	if(str.equalsIgnoreCase(src)){
        		src_num = (int)me.getKey();
        	}
        	if(dest.equalsIgnoreCase(str)){
        		dest_num = (int)me.getKey();
        	}
        	//System.out.print(me.getKey() + ": ");
        	//System.out.println(me.getValue());
        }
        if(src_num == dest_num || src_num == -1 || dest_num == -1){// If src or dest strings are not in the list, prompt the user and exit from the program
        	System.out.println("Please Enter the correct City Name!!");
        	System.exit(0);
        }
        t.dijkstra(graph, hm, src_num, dest_num);// Passing Src and dest.
    }
}