class CitiesController < ApplicationController
  def index
  	@cities = City.new
  end

  def create
  	#@cities = City.create(city_params)
	  	smallest = Graph.new
		  	smallest.add_vertex('Bangalore', {'Belgaum' => 24, 'Mysore' => 71})
			smallest.add_vertex('Mysore', {'Mandya' => 101, 'Mangalore' => 169, 'Tumkur' => 134})
			smallest.add_vertex('Mandya', {'Tumkur' => 65.5, 'Mangalore' => 141, 'Mysore' => 101})
			smallest.add_vertex('Mangalore', {'Mandya' => 141, 'Mysore' => 169})
			smallest.add_vertex('Tumkur', {'Mandya' => 65.5, 'Mysore' => 134, 'Belgaum' => 59})
			smallest.add_vertex('Belgaum', {'Bangalore' => 24, 'Chickmagalur' => 103, 'Tumkur' => 59})
			smallest.add_vertex('Chickmagalur', {'Belgaum' => 103})
  				@dist_hash = smallest.shortest_path(params[:city][:from], params[:city][:to]);
  				puts @dist_hash
  					redirect_to :action => 'details', id: @dist_hash
  end

  def details
  	#puts params[:id]
  	@dist = params[:id]
  end

  private 

  def city_params
  	params.require(:city).permit(:from, :to)
  end
end
