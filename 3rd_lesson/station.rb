class Station
  attr_reader :arrived_trains, :name

  def initialize(name)
    @name = name
    @arrived_trains = []
  end

  def arrival(train)
    @arrived_trains << train
  end  

  def departure(train)
    @arrived_trains.delete(train)
  end

  def list_of_trains
    cargo = @arrived_trains.count { |train| train.type == 'грузовой' }
    passenger = @arrived_trains.count { |train| train.type == 'пассажирский' }
    [cargo, passenger]
  end
end

