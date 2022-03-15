class Route
  include InstanceCounter

  @@all = []

  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
    self.class.all << self.name
    register_instance
  end

  def self.all
    @@all
  end
  
  def name
    [stations[0].name, stations[-1].name]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end
end

