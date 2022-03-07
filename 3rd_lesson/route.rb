class Route

  def initialize(start, finish)
    @start = start
    @finish = finish
    @additional_stations = []
  end

  def add_station(station)
    @additional_stations << station
  end

  def delete_station(station)
    @additional_stations.delete(station)
  end

  def show_stations
    station_names = full_route.map { |station| station.name }
    puts station_names.join(', ')
  end

  def full_route
    [@start]+ @additional_stations + [@finish]
  end
end

